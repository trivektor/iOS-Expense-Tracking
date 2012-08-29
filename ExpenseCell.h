//
//  ExpenseCell.h
//  Expense Tracking
//
//  Created by Tri Vuong on 8/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExpenseCell : UITableViewCell
{
    
}

@property (weak, nonatomic) IBOutlet UILabel *expenseNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *expenseDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *expenseAmountLabel;


@end
