//
//  FeedbackViewController.m
//  Expense Tracking
//
//  Created by Tri Vuong on 9/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FeedbackViewController.h"
#import "SpinnerView.h"

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
    [feedbackTextView setDelegate:self];
    
    [self.navigationItem setTitle:@"Feedback"];
    [self.view setBackgroundColor:[UIColor clearColor]];
    [sendFeedbackButton setTitleColor:[UIColor colorWithRed:141/255.0 green:67/255.0 blue:2/255.0 alpha:1] forState:UIControlStateNormal];
    
    UIBarButtonItem *refreshButton = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonSystemItemRefresh target:self action:@selector(clearFeedbackForm)];
    [refreshButton setTintColor:[UIColor blackColor]];
    [refreshButton setImage:[UIImage imageNamed:@"refresh_icon.png"]];
    [self.navigationItem setRightBarButtonItem:refreshButton];
    
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

- (IBAction)sendFeedbackButtonTapped:(id)sender
{
    self.spinnerView = [SpinnerView loadSpinnerIntoView:self.view];
    
    NSMutableURLRequest *request = [NSMutableURLRequest 
									requestWithURL:[NSURL URLWithString:@"http://expense-tracking.herokuapp.com/feedback"]];
    NSString *requestParams = @"name=";
    requestParams = [requestParams stringByAppendingString:nameTextField.text];
    requestParams = [requestParams stringByAppendingString:@"&email="];
    requestParams = [requestParams stringByAppendingString:emailTextField.text];
    requestParams = [requestParams stringByAppendingString:@"feedback="];
    requestParams = [requestParams stringByAppendingString:feedbackTextView.text];
    
    NSString *params = [[NSString alloc] initWithFormat:requestParams];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[params dataUsingEncoding:NSUTF8StringEncoding]];
    [[NSURLConnection alloc] initWithRequest:request delegate:self];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    [self.spinnerView removeFromSuperview];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Your feedback has been sent" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}

- (void)clearFeedbackForm
{
    [nameTextField setText:@""];
    [emailTextField setText:@""];
    [feedbackTextView setText:@""];
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
