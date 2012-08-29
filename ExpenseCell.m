//
//  ExpenseCell.m
//  Expense Tracking
//
//  Created by Tri Vuong on 8/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ExpenseCell.h"

@implementation ExpenseCell

@synthesize expenseNameLabel;
@synthesize expenseAmountLabel;
@synthesize expenseDateLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
