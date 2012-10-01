//
//  SignupViewController.m
//  Expense Tracking
//
//  Created by Tri Vuong on 9/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SignupViewController.h"
#import "LoginViewController.h"
#import "SpinnerView.h"
#import "AFJSONRequestOperation.h"
#import "AFHTTPClient.h"

@interface SignupViewController ()

@end

@implementation SignupViewController

@synthesize spinnerView;

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
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:nil action:nil];
    [backButton setTintColor:[UIColor blackColor]];
    [self.navigationItem setBackBarButtonItem:backButton];
    [self.navigationItem setTitle:@"Account Signup"];
    
    UIBarButtonItem *_loginButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"lock_icon_white.png"] style:UIBarButtonItemStylePlain target:self action:@selector(sendToLoginForm)];
    [_loginButton setTintColor:[UIColor blackColor]];
    [self.navigationItem setRightBarButtonItem:_loginButton];
    
    self.view.backgroundColor = [UIColor clearColor];
    [signupButton setTitleColor:[UIColor colorWithRed:141/255.0 green:67/255.0 blue:2/255.0 alpha:1] forState:UIControlStateNormal];
    
    [emailField setDelegate:self];
    [passwordField setDelegate:self];
}

- (void)viewDidUnload
{
    emailField = nil;
    passwordField = nil;
    signupButton = nil;
    loginButton = nil;
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
    } else {
        NSURL *signupURL = [NSURL URLWithString:@"http://192.168.0.4:3000/users.json"];
        
        AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:signupURL];
        
        NSMutableDictionary *userParams = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                           [emailField text], @"email", 
                                           [passwordField text], @"password",
                                           [passwordField text], @"password_confirmation",
                                           nil];
        
        NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                userParams, @"user",
                                nil];
        
        NSMutableURLRequest *postRequest = [httpClient requestWithMethod:@"POST" path:signupURL.absoluteString parameters:params];
        //[postRequest setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        
        AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:postRequest];
        
        [operation setCompletionBlockWithSuccess:
            ^(AFHTTPRequestOperation *operation, id responseObject) {
                NSString *response = [operation responseString];
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];

                NSDictionary *json = [NSJSONSerialization JSONObjectWithData:[response dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
                
                if ([[json valueForKey:@"success"] intValue] == 1) {
                    [alert setMessage:[json valueForKey:@"message"]];
                } else {
                    [alert setMessage:[json valueForKey:@"errors"]];
                }
                
                [alert show];
                [self.spinnerView removeFromSuperview];
            }
        failure:
            ^(AFHTTPRequestOperation *operation, NSError *error) {
                NSLog(@"error: %@", [operation error]);
            }
        ];
        
        self.spinnerView = [SpinnerView loadSpinnerIntoView:self.view];
        [operation start];
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

- (void)sendToLoginForm
{
    LoginViewController *l = [[LoginViewController alloc] init];
    [self.navigationController pushViewController:l animated:YES];
}

- (IBAction)loginButtonTapped:(id)sender
{
    [self sendToLoginForm];
}

@end
