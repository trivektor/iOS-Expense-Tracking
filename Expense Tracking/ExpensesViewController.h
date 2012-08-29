//
//  ExpensesViewController.h
//  Expense Tracking
//
//  Created by Tri Vuong on 8/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExpensesViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
{
    UITableView *tableView;
}

@property (nonatomic, strong) NSMutableArray *expenses;
@property (nonatomic, retain) UITableView *tableView;

@end
