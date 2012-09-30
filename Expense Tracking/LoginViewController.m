//
//  LoginViewController.m
//  Expense Tracking
//
//  Created by Tri Vuong on 9/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

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
    [self.navigationItem setTitle:@"Login"];
    
    [self.view setBackgroundColor:[UIColor clearColor]];
    [loginButton setTitleColor:[UIColor colorWithRed:141/255.0 green:67/255.0 blue:2/255.0 alpha:1] forState:UIControlStateNormal];
    
    [emailField setDelegate:self];
    [passwordField setDelegate:self];
}

- (void)viewDidUnload
{
    emailField = nil;
    passwordField = nil;
    loginButton = nil;
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
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)loginButtonTapped:(id)sender
{
    if (emailField.text.length == 0 || passwordField.text.length == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Please enter both email and password" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        [alert show];
    } else {
        
    }
}

@end
