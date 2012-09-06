//
//  ExpensesViewController.h
//  Expense Tracking
//
//  Created by Tri Vuong on 8/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Expense.h"

@interface ExpensesViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
{
    UITableView *tableView;
}

@property (nonatomic, strong) Expense *expenseDAO;
@property (nonatomic, strong) NSMutableArray *expenses;
@property (nonatomic, retain) UITableView *tableView;

- (id)initWithExpenses:(NSMutableArray *)expenses;
- (void) addNewExpense;

@end
