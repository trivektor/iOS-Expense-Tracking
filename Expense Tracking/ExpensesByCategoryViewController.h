//
//  ExpensesByCategoryViewController.h
//  Expense Tracking
//
//  Created by Tri Vuong on 9/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExpensesByCategoryViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
    
    __weak IBOutlet UITableView *expensesTable;
}

@property (nonatomic, retain) NSMutableDictionary *expenseCategories;
@property (nonatomic, retain) NSMutableArray *expenses;
@property (nonatomic, retain) NSString *categoryName;
@property (nonatomic) double expenseSum;

- (id)initWithCategoryName:(NSString *)name;

@end
