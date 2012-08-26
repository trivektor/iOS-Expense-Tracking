//
//  NewExpenseViewController.h
//  Expense Tracking
//
//  Created by Tri Vuong on 8/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface NewExpenseViewController : UIViewController <UITextFieldDelegate>
{
    __weak IBOutlet UITextField *nameTextField;
    __weak IBOutlet UITextField *amountTextField;
    __weak IBOutlet UITextField *taxTextField;
    __weak IBOutlet UITextField *tipTextField;
    __weak IBOutlet UITextView *descriptionTextField;
    __weak IBOutlet UIButton *addExpenseButton;
}

- (IBAction)addExpenseButtonTapped:(id)sender;

@end
