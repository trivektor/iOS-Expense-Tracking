//
//  SignupViewController.m
//  Expense Tracking
//
//  Created by Tri Vuong on 9/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SignupViewController.h"

@interface SignupViewController ()

@end

@implementation SignupViewController

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
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] init];
    [backButton setTintColor:[UIColor blackColor]];
    [self.navigationItem setBackBarButtonItem:backButton];
    [self.navigationItem setTitle:@"Account Signup"];
    
    self.view.backgroundColor = [UIColor clearColor];
    [signupButton setTitleColor:[UIColor colorWithRed:141/255.0 green:67/255.0 blue:2/255.0 alpha:1] forState:UIControlStateNormal];
}

- (void)viewDidUnload
{
    emailField = nil;
    passwordField = nil;
    signupButton = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)signupButtonTapped:(id)sender
{
    if (emailField.text.length == 0 || passwordField.text.length == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Please enter both username and password" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        return;
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return TRUE;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    return TRUE;
}

@end
