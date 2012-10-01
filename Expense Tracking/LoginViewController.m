//
//  LoginViewController.m
//  Expense Tracking
//
//  Created by Tri Vuong on 9/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "LoginViewController.h"
#import "SignupViewController.h"
#import "ServerUploadViewController.h"
#import "SpinnerView.h"
#import "AFHTTPClient.h"
#import "AFHTTPRequestOperation.h"
#import "KeyChainItemWrapper.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

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
    signupButton = nil;
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

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    return YES;
}

- (void)loginButtonTapped:(id)sender
{
    if (emailField.text.length == 0 || passwordField.text.length == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Please enter both email and password" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        [alert show];
    } else {
        NSURL *signinURL = [NSURL URLWithString:@"http://thawing-oasis-5679.herokuapp.com/api/tokens.json"];
        
        AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:signinURL];
        
        NSMutableDictionary *userParams = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                           [emailField text], @"email", 
                                           [passwordField text], @"password",
                                           nil];
        
        NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                       userParams, @"user",
                                       nil];
        
        NSMutableURLRequest *postRequest = [httpClient requestWithMethod:@"POST" path:signinURL.absoluteString parameters:params];
        
        AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:postRequest];
        
        [operation setCompletionBlockWithSuccess:
         ^(AFHTTPRequestOperation *operation, id responseObject) {
             NSString *response = [operation responseString];
             
             UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
             
             NSDictionary *json = [NSJSONSerialization JSONObjectWithData:[response dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
             
             if ([[json valueForKey:@"success"] intValue] == 1) {
                 [alert setMessage:[json valueForKey:@"message"]];
                 
                 NSString *token = [json valueForKey:@"token"];
                 NSLog(@"%@", token);
                 
                 KeychainItemWrapper *keychain = [[KeychainItemWrapper alloc] initWithIdentifier:@"ExpenseTrackingKeychain" accessGroup:nil];
                 
                 [keychain setObject:token forKey:(__bridge id)kSecAttrAccount];
                 ServerUploadViewController *s = [[ServerUploadViewController alloc] init];
                 [self.navigationController pushViewController:s animated:YES];
             } else {
                 [alert setTitle:@"Error"];
                 [alert setMessage:[json valueForKey:@"errors"]];
             }
             
             //[self.spinnerView removeFromSuperview];
         }
                                         failure:
         ^(AFHTTPRequestOperation *operation, NSError *error) {
             NSLog(@"error: %@", [operation error]);
         }];
        
        //self.spinnerView = [SpinnerView loadSpinnerIntoView:self.view];
        [operation start];

    }
}

- (IBAction)signupButtonTapped:(id)sender
{
    SignupViewController *s = [[SignupViewController alloc] init];
    [self.navigationController pushViewController:s animated:YES];
}

@end
