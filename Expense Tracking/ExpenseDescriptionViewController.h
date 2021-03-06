//
//  ExpenseDescriptionViewController.h
//  Expense Tracking
//
//  Created by Tri Vuong on 9/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Expense.h"

@protocol ExpenseDescriptionViewController <NSObject>
- (void) didFinishComposingDescriptionForExpense:(Expense *)expense;
@end

@interface ExpenseDescriptionViewController : UIViewController
{
    
    __weak IBOutlet UITextView *descriptionTextView;
}

@property (nonatomic, weak) id <ExpenseDescriptionViewController> delegate;
@property (nonatomic, retain) Expense *expense;

- (void)doneDescription;

@end
