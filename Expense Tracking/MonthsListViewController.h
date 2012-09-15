//
//  MonthsListViewController.h
//  Expense Tracking
//
//  Created by Tri Vuong on 9/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MonthsListViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
{
    IBOutlet UITableView *monthsTable;
}

@property (nonatomic, retain) NSMutableArray *monthsArray;

@end
