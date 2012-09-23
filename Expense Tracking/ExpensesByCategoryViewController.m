//
//  ExpensesByCategoryViewController.m
//  Expense Tracking
//
//  Created by Tri Vuong on 9/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ExpensesByCategoryViewController.h"
#import "Expense.h"
#import "ExpenseCategory.h"
#import "ExpenseCell.h"

@interface ExpensesByCategoryViewController ()

@end

@implementation ExpensesByCategoryViewController

@synthesize categoryName, expenses, expenseCategories, expenseSum;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    self.expenseSum = 0;
    if (self) {
        // Custom initialization
        self.expenses = [[NSMutableArray alloc] initWithObjects:nil];
        
        Expense *e = [[Expense alloc] init];
        self.expenseCategories = [e groupExpensesByCategories];
        
        for (id key in self.expenseCategories) {
            //NSLog(@"%@", [self.expenseCategories objectForKey:key]);
            ExpenseCategory *ec = [[ExpenseCategory alloc] init];
            ec.name = key;
            ec.total = [[self.expenseCategories objectForKey:key] doubleValue];
            self.expenseSum += ec.total;
            [self.expenses addObject:ec];
        }
    }
    return self;
}

- (id)initWithCategoryName:(NSString *)name
{
    self = [super init];
    self.categoryName = name;
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.navigationItem setTitle:@"Expenses By Category"];
    
    UINib *nib = [UINib nibWithNibName:@"ExpenseCell" bundle:nil];
    
    [expensesTable registerNib:nib forCellReuseIdentifier:@"ExpenseCell"];
}

- (void)viewDidUnload
{
    expensesTable = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView 
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.expenses count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ExpenseCell *cell = [expensesTable dequeueReusableCellWithIdentifier:@"ExpenseCell"];
    
    if (!cell) {
        cell = [[ExpenseCell alloc] init];
    }
    
    ExpenseCategory *ec = [self.expenses objectAtIndex:[indexPath row]];
    [cell.expenseNameLabel setText:ec.name];
    [cell.expenseNameLabel setFrame:CGRectMake(10, 16, 194, 21)];
    [cell.expenseAmountLabel setText:[NSString stringWithFormat:@"$%.02f", ec.total]];
    [cell.expenseAmountLabel setFrame:CGRectMake(246, 13, 65, 29)];
    [cell.expenseDateLabel removeFromSuperview];
    
    cell.backgroundView = [[UIView alloc] initWithFrame:cell.frame];
    cell.backgroundView.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    double barWidth = 320*ec.total/self.expenseSum;
    UIView *bar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, barWidth, 53)];
    [bar setBackgroundColor:[UIColor colorWithRed:224/255.0 green:231/255.0 blue:255/255.0 alpha:0.89]];
    [cell addSubview:bar];
    [cell sendSubviewToBack:bar];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 53;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
