//
//  CategoriesViewController.h
//  Expense Tracking
//
//  Created by Tri Vuong on 9/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CategoriesViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, retain) NSArray *categories;
@property (nonatomic, retain) UITableView *tableView;

@end
