//
//  ExpensesViewController.m
//  Expense Tracking
//
//  Created by Tri Vuong on 8/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ExpensesViewController.h"
#import "NewExpenseViewController.h"
#import "ExpenseDetailsViewController.h"
#import "Expense.h"
#import "ExpenseCell.h"

@interface ExpensesViewController ()

@end

@implementation ExpensesViewController

@synthesize expenseDAO, expenses, tableView;

- (id)initWithExpenses:(NSMutableArray *)_expenses
{
    self = [super init];
    self.expenses = _expenses;
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)loadView
{
    UIView *mainView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
    mainView.backgroundColor = [UIColor whiteColor];
    self.view = mainView;
    
    UIImageView *topBorderView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"envelope_border.png"]];
    [self.view addSubview:topBorderView];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 4, 320, 480) style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.backgroundColor = [UIColor clearColor];
    
    // Make sure that we don't have to touch and drag the table view upward to see the last row
    // http://stackoverflow.com/questions/7678910/uitableviewcontroller-last-row-cut-off
    self.tableView.autoresizingMask = ~UIViewAutoresizingFlexibleBottomMargin;
    
    [self.view addSubview:self.tableView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.navigationItem setTitle:@"All Expenses"];
    
//    UIImageView *backgroundImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"envelope_form.png"]];
//    [backgroundImage setFrame:self.tableView.frame];
//    [self.tableView setBackgroundView:backgroundImage];
    
    UINib *nib = [UINib nibWithNibName:@"ExpenseCell" bundle:nil];
    
    [self.tableView registerNib:nib forCellReuseIdentifier:@"ExpenseCell"];
    
//    UIBarButtonItem *plusSignButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"white_plus_sign.png"] style:UIBarButtonSystemItemAdd target:nil action:nil];
//    
    UIBarButtonItem *plusSignBtn = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonSystemItemAdd target:self action:@selector(addNewExpense)];
    [plusSignBtn setTintColor:[UIColor blackColor]];
    [plusSignBtn setImage:[UIImage imageNamed:@"white_plus_sign.png"]];
    [self.navigationItem setRightBarButtonItem:plusSignBtn];
}

- (void)viewDidUnload
{
    self.tableView = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.expenses count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ExpenseCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"ExpenseCell"];

    Expense *e = [self.expenses objectAtIndex:[indexPath row]];
    
    if (e.name.length >= 18) {
        NSString *truncatedExpenseName = [e.name substringToIndex:MIN(18, e.name.length)];
        cell.expenseNameLabel.text = [truncatedExpenseName stringByAppendingString:@"..."];
    } else {
        cell.expenseNameLabel.text = e.name;
    }
    cell.expenseAmountLabel.text = [NSString stringWithFormat:@"$%.02f", e.amount];    
    cell.expenseDateLabel.text = e.createdAt;
    
    cell.backgroundView = [[UIView alloc] initWithFrame:cell.frame];
    cell.backgroundView.backgroundColor = [UIColor whiteColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        Expense *deletedExpense = [self.expenses objectAtIndex:[indexPath row]];
        [self.expenses removeObjectIdenticalTo:deletedExpense];
        [self.expenseDAO deleteExpenseByID:deletedExpense.expenseId];
        [self.tableView reloadData];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 63;
}

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ExpenseDetailsViewController *d = [[ExpenseDetailsViewController alloc] init];
    [d setExpenseItem:[self.expenses objectAtIndex:[indexPath row]]];
    [self addBackButton];
    [self.navigationController pushViewController:d animated:YES];
}

- (void)addNewExpense
{
    NewExpenseViewController *n = [[NewExpenseViewController alloc] init];
    [self addBackButton];
    [self.navigationController pushViewController:n animated:YES];
}

- (void)addBackButton
{
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:nil action:nil];
    [backButton setTintColor:[UIColor blackColor]];
    [self.navigationItem setBackBarButtonItem:backButton];
}

@end
