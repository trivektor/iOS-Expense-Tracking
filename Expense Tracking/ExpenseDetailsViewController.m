//
//  ExpenseDetailsViewController.m
//  Expense Tracking
//
//  Created by Tri Vuong on 8/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ExpenseDetailsViewController.h"
#import "ExpenseDetailCell.h"

@interface ExpenseDetailsViewController ()

@end

@implementation ExpenseDetailsViewController

@synthesize expenseItem, tableView, sectionNames;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.sectionNames = [NSArray arrayWithObjects:@"Name", @"Amount", @"Tax", @"Tip", @"Category", @"Description", @"Date", nil];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.navigationItem setTitle:self.expenseItem.name];
    
    UIImageView *topBorderView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"envelope_border.png"]];
    [self.view addSubview:topBorderView];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 4, 320, 400) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    UINib *nib = [UINib nibWithNibName:@"ExpenseDetailCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"ExpenseDetailCell"];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ExpenseDetailCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"ExpenseDetailCell"];
    [cell.sectionName setText:[self.sectionNames objectAtIndex:[indexPath row]]];
    
    int row = [indexPath row];
    
    if (row == 0) {
        [cell.expenseDetail setText:self.expenseItem.name];
    } else if (row == 1) {
        [cell.expenseDetail setText:[NSString stringWithFormat:@"%.02f", self.expenseItem.amount]];
    } else if (row == 2) {
        [cell.expenseDetail setText:[NSString stringWithFormat:@"%.02f", self.expenseItem.tax]];
    } else if (row == 3) {
        [cell.expenseDetail setText:[NSString stringWithFormat:@"%.02f", self.expenseItem.tip]];
    } else if (row == 4) {
        [cell.expenseDetail setText:@""];
    } else if (row == 5) {
        [cell.expenseDetail setText:@""];
    } else if (row == 6) {
        [cell.expenseDetail setText:self.expenseItem.createdAt];
    }
    
    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 7;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 49;
}


@end
