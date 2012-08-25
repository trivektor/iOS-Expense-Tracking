//
//  NewExpenseViewController.h
//  Expense Tracking
//
//  Created by Tri Vuong on 8/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface NewExpenseViewController : UIViewController
{
    
    __weak IBOutlet UITextField *nameField;
    __weak IBOutlet UITextField *amountField;
    __weak IBOutlet UITextField *taxField;
    __weak IBOutlet UITextField *tipField;
    __weak IBOutlet UITextField *categoryField;
    __weak IBOutlet UITextView *descriptionField;
    __weak IBOutlet UIButton *addButton;
}

@end
