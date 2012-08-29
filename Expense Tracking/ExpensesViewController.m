//
//  ExpensesViewController.m
//  Expense Tracking
//
//  Created by Tri Vuong on 8/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ExpensesViewController.h"
#import "Expense.h"
#import "ExpenseCell.h"

@interface ExpensesViewController ()

@end

@implementation ExpensesViewController

@synthesize expenses;
@synthesize tableView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.expenses = [[[Expense alloc] init] getAll];
    }
    return self;
}

- (void)loadView
{
    UIView *mainView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
    self.view = mainView;
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(13, 10, 294, 397) style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:self.tableView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.navigationItem setTitle:@"All Expenses"];
    
    [self.view setBackgroundColor:[UIColor clearColor]];
    
    UIImageView *backgroundImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"envelope_form.png"]];
    [backgroundImage setFrame:self.tableView.frame];
    [self.tableView setBackgroundView:backgroundImage];
    
    UINib *nib = [UINib nibWithNibName:@"ExpenseCell" bundle:nil];
    
    [self.tableView registerNib:nib forCellReuseIdentifier:@"ExpenseCell"];
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
    NSString *truncatedExpenseName = [e.name substringToIndex:MIN(18, e.name.length)];
    
    cell.expenseNameLabel.text = [truncatedExpenseName stringByAppendingString:@"..."];
    cell.expenseAmountLabel.text = [NSString stringWithFormat:@"$%.02f", e.amount];
    cell.expenseDateLabel.text = @"05/30/2012";
    
    cell.backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 275, 70)];
    cell.selectedBackgroundView.backgroundColor = [UIColor orangeColor];
    cell.backgroundColor = [UIColor clearColor];
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
        // Delete the row from the data source
        //[tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
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
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
