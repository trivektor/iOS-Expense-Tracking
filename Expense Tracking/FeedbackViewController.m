//
//  FeedbackViewController.m
//  Expense Tracking
//
//  Created by Tri Vuong on 9/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FeedbackViewController.h"
#import "SpinnerView.h"
#import "AFJSONRequestOperation.h"
#import "AFHTTPClient.h"

@interface FeedbackViewController ()

@end

@implementation FeedbackViewController
@synthesize nameTextField;
@synthesize emailTextField;
@synthesize feedbackTextView;
@synthesize sendFeedbackButton;
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
    [nameTextField setDelegate:self];
    [emailTextField setDelegate:self];
    
    [self.navigationItem setTitle:@"Feedback"];
    [self.view setBackgroundColor:[UIColor clearColor]];
    [sendFeedbackButton setTitleColor:[UIColor colorWithRed:141/255.0 green:67/255.0 blue:2/255.0 alpha:1] forState:UIControlStateNormal];
    
    UIBarButtonItem *trashButton = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonSystemItemRefresh target:self action:@selector(clearFeedbackForm)];
    [trashButton setTintColor:[UIColor blackColor]];
    [trashButton setImage:[UIImage imageNamed:@"trash_icon.png"]];
    [self.navigationItem setRightBarButtonItem:trashButton];
    
    UITapGestureRecognizer *feedbackKeyboardOutsideTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissFeedbackKeyboard)];
    [feedbackKeyboardOutsideTap setCancelsTouchesInView:NO];
    [self.view addGestureRecognizer:feedbackKeyboardOutsideTap];
}

- (void)viewDidUnload
{
    [self setNameTextField:nil];
    [self setEmailTextField:nil];
    [self setFeedbackTextView:nil];
    [self setSendFeedbackButton:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)sendFeedbackButtonTapped:(id)sender
{
    self.spinnerView = [SpinnerView loadSpinnerIntoView:self.view];
    
    NSURL *baseURL = [NSURL URLWithString:@"http://expense-tracking.herokuapp.com"];
    
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:baseURL];
    [httpClient defaultValueForHeader:@"Accept"];
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            [nameTextField text], @"name",
                            [emailTextField text], @"email",
                            [feedbackTextView text], @"feedback",
                            nil];
    
    NSMutableURLRequest *request = [httpClient requestWithMethod:@"POST" 
                                                            path:@"http://expense-tracking.herokuapp.com/feedback" 
                                                      parameters:params];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    
    [httpClient registerHTTPOperationClass:[AFHTTPRequestOperation class]];
    
    [operation setCompletionBlockWithSuccess:
        ^(AFHTTPRequestOperation *operation, id responseObject) {
            NSString *response = [operation responseString];
            NSDictionary *json = [NSJSONSerialization JSONObjectWithData:[response dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
            
            UIAlertView *alert;

            if ([[json valueForKey:@"success"] integerValue] == 1) {
                alert = [[UIAlertView alloc] initWithTitle:@"Alert" 
                                                   message:[json valueForKey:@"message"]
                                                  delegate:self 
                                         cancelButtonTitle:@"OK" 
                                         otherButtonTitles:nil];
                
            } else {
                alert = [[UIAlertView alloc] initWithTitle:@"Alert" 
                                                   message:@"An error ocurred while sending feedback" 
                                                  delegate:self 
                                         cancelButtonTitle:@"OK" 
                                         otherButtonTitles:nil];
            }
            
            [alert show];
            [self.spinnerView removeFromSuperview];
        }
     failure:
        ^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"error: %@", [operation error]);
        }
     ];
    
    [operation start];
}

- (void)clearFeedbackForm
{
    [nameTextField setText:@""];
    [emailTextField setText:@""];
    [feedbackTextView setText:@""];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (feedbackTextView.isFirstResponder) {
        [feedbackTextView resignFirstResponder];
    }
    
    [textField resignFirstResponder];
    return YES;
}

- (void)dismissFeedbackKeyboard
{
    [feedbackTextView resignFirstResponder];
}

@end
