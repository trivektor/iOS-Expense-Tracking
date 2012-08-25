//
//  NewExpenseViewController.m
//  Expense Tracking
//
//  Created by Tri Vuong on 8/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NewExpenseViewController.h"

@interface NewExpenseViewController ()

@end

@implementation NewExpenseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
     
    // Do any additional setup after loading the view from its nib.
//    amountField.delegate = self;
    nameTextField.delegate = self;
//    taxField.delegate = self;
//    tipField.delegate = self;
//    categoryField.delegate = self;
//    
    [self.view setBackgroundColor:[UIColor clearColor]];
    [self.navigationItem setTitle:@"Add Expense"];
//    
//    [addButton.layer setCornerRadius:8.0f];
//    [addButton.layer setMasksToBounds:YES];
//    [addButton.layer setBorderWidth:1.0f];
//    [addButton.layer setBackgroundColor:[UIColor orangeColor].CGColor];
//    [addButton setBackgroundColor:[UIColor orangeColor]];
//    [addButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
//    [addButton.layer setBackgroundColor:[UIColor orangeColor].CGColor];
//    [addButton setTintColor:[UIColor orangeColor]];
//    [addButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
//    gradientLayer.frame = addButton.layer.bounds;
//    gradientLayer.colors = [NSArray arrayWithObjects:
//                            [UIColor colorWithHue:0x45/255.0 saturation:0x63/255.0 brightness:0x99/255.0 alpha:1.0].CGColor,
//                            [UIColor colorWithHue:0x39/255.0 saturation:0x84/255.0 brightness:0x96/255.0 alpha:1.0].CGColor,
//                            nil];
//    gradientLayer.cornerRadius = addButton.layer.cornerRadius;
//    [addButton.layer addSublayer:gradientLayer];
//    [addButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    //[addButton.layer setBorderColor:[UIColor ].CGColor];
}

- (void)viewDidUnload
{
    nameTextField = nil;
    amountTextField = nil;
    taxTextField = nil;
    tipTextField = nil;
    descriptionTextField = nil;
    addExpenseButton = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if ([text isEqual:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

@end
