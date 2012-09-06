//
//  MonthsViewController.m
//  Expense Tracking
//
//  Created by Tri Vuong on 9/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MonthsViewController.h"

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
    NSLog(@"viewing month expenses");
}

@end
