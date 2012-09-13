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

@interface UILabel (BPExtensions)
- (void)sizeToFitFixedWith:(CGFloat)fixedWith;
@end

@implementation UILabel (BPExtensions)

- (void)sizeToFitFixedWith:(CGFloat)fixedWith
{
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, fixedWith, 0);
    self.lineBreakMode = UILineBreakModeWordWrap;
    self.numberOfLines = 0;
    [self sizeToFit];
}

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
    [cell.expenseDetail setText:self.expenseItem.description];
    [cell setSelectionStyle:UITableViewCellEditingStyleNone];
    
    int row = [indexPath row];
    
    if (row == 0) {
        [cell.expenseDetail setNumberOfLines:0];
        [cell.expenseDetail setText:self.expenseItem.name];
        [cell.expenseDetail sizeToFitFixedWith:193];
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
    
    // Make the expense detail label stretched enough to fit its text without resizing
    // http://stackoverflow.com/questions/793015/how-to-fit-a-text-in-uilabel-when-the-size-is-not-proportionally
//    CGRect bounds = cell.expenseDetail.bounds;
//    bounds.size = [cell.expenseDetail.text sizeWithFont:cell.expenseDetail.font];
//    cell.expenseDetail.bounds = bounds;
    
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
    int row = [indexPath row];
    
    if (row == 0 || row == 5) {
        // Nice solution to calculate UITableViewCell height dynamically based on the height of the label it contains
        // http://stackoverflow.com/questions/1012361/resize-uitableviewcell-to-the-labels-height-dynamically
        NSString *text = [self.expenseItem.name stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        
        CGSize size = [text sizeWithFont:[UIFont systemFontOfSize:14.0]
                       constrainedToSize:CGSizeMake(193, 999)
                           lineBreakMode:UILineBreakModeWordWrap];
        
        return size.height + 28;

    } else {
        return 49;  
    }
}


@end
