//
//  ExpenseDetailsViewController.h
//  Expense Tracking
//
//  Created by Tri Vuong on 8/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Expense.h"

@interface ExpenseDetailsViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
{
    UITableView *tableView;
    NSArray *sectionNames;
}

@property (nonatomic, retain) Expense *expenseItem;
@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, retain) NSArray *sectionNames;

@end
