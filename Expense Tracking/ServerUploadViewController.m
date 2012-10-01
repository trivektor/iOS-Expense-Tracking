//
//  ServerUploadViewController.m
//  Expense Tracking
//
//  Created by Tri Vuong on 9/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ServerUploadViewController.h"
#import "AFHTTPClient.h"
#import "AFHTTPRequestOperation.h"
#import "KeyChainItemWrapper.h"
#import "LoginViewController.h"

@interface ServerUploadViewController ()

@end

@implementation ServerUploadViewController

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
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:nil action:nil];
    [backButton setTintColor:[UIColor blackColor]];
    [self.navigationItem setBackBarButtonItem:backButton];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
