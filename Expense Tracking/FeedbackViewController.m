//
//  FeedbackViewController.m
//  Expense Tracking
//
//  Created by Tri Vuong on 9/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FeedbackViewController.h"

@interface FeedbackViewController ()

@end

@implementation FeedbackViewController
@synthesize nameTextField;
@synthesize emailTextField;
@synthesize feedbackTextView;
@synthesize sendFeedbackButton;

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

- (void)clearFeedbackForm
{
    [nameTextField setText:@""];
    [emailTextField setText:@""];
    [feedbackTextView setText:@""];
}

@end
