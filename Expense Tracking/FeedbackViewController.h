//
//  FeedbackViewController.h
//  Expense Tracking
//
//  Created by Tri Vuong on 9/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FeedbackViewController : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextView *feedbackTextView;
@property (weak, nonatomic) IBOutlet UIButton *sendFeedbackButton;
@property (strong, nonatomic) UIView *spinnerView;

- (void)sendFeedbackButtonTapped:(id)sender;
- (void)clearFeedbackForm;

@end
