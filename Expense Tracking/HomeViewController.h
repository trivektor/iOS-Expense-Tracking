//
//  HomeViewController.h
//  Expense Tracking
//
//  Created by Tri Vuong on 8/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
{
    UITableView *tableView;
}

@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, retain) NSMutableArray *options;
@property (nonatomic, retain) NSMutableArray *optionIcons;

@end
