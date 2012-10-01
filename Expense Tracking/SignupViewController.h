//
//  SignupViewController.h
//  Expense Tracking
//
//  Created by Tri Vuong on 9/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignupViewController : UIViewController <UITextFieldDelegate>
{
    __weak IBOutlet UITextField *emailField;
    __weak IBOutlet UITextField *passwordField;
    __weak IBOutlet UIButton *signupButton;
    __weak IBOutlet UIButton *loginButton;
}

@property (nonatomic, strong) UIView *spinnerView;

- (IBAction)signupButtonTapped:(id)sender;
- (void)dismissSignupForm;

@end
