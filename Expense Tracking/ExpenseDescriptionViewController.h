//
//  ExpenseDescriptionViewController.h
//  Expense Tracking
//
//  Created by Tri Vuong on 9/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Expense.h"

@interface ExpenseDescriptionViewController : UIViewController
{
    
    __weak IBOutlet UITextView *descriptionTextView;
}

@property (nonatomic, retain) Expense *expense;

@end
