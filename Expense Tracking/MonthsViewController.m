//
//  MonthsViewController.m
//  Expense Tracking
//
//  Created by Tri Vuong on 9/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MonthsViewController.h"
#import "ExpensesViewController.h"
#import "Expense.h"

@interface MonthsViewController ()
@end

@implementation MonthsViewController

-(id)init
{
    self = [super init];
    return self;
}

-(void)viewDidLoad
{
    UIBarButtonItem *b = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleBordered target:self action:@selector(viewMonthExpenses)];
    [b setTintColor:[UIColor blackColor]];
    [b setImage:[UIImage imageNamed:@"expenses_list.png"]];
    [self.navigationItem setRightBarButtonItem:b];
}

-(void)didSelectDate:(KalDate *)date
{
    NSLog(@"%@", date);
}

-(void)viewMonthExpenses 
{
    // Get the first and last dates of the selected month
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *comp = [calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:self.selectedDate];
    [comp setDay:1];
    NSDate *firstDayOfMonth = [calendar dateFromComponents:comp];
    [comp setMonth:(comp.month + 1)];
    NSDate *lastDayOfMonth = [calendar dateFromComponents:comp];
    
    // Get the expenses between the first and last dates above
    Expense *dao = [[Expense alloc] init];
    NSMutableArray *expenses = [dao findBetweenFirstDate:firstDayOfMonth LastDate:lastDayOfMonth];
    
    UIBarButtonItem *b = [[UIBarButtonItem alloc] init];
    [b setTintColor:[UIColor blackColor]];
    [self.navigationItem setBackBarButtonItem:b];
    
    // Display in an ExpensesViewController
    ExpensesViewController *e = [[ExpensesViewController alloc] initWithExpenses:expenses];
    [self.navigationController pushViewController:e animated:YES];
}

@end
