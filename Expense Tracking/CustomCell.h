//
//  CustomCell.h
//  Expense Tracking
//
//  Created by Tri Vuong on 8/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomCell : UITableViewCell
{
    IBOutlet UILabel *expenseName;
}

@property (nonatomic, retain) IBOutlet UILabel *expenseName;

@end
