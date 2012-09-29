//
//  ReceiptViewController.m
//  Expense Tracking
//
//  Created by Tri Vuong on 9/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ReceiptViewController.h"

@interface ReceiptViewController ()

@end

@implementation ReceiptViewController

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
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"header.png"] forBarMetrics:UIBarMetricsDefault];
    [self.navigationItem setTitle:@"Receipt"];
    
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(dismiss)];
    [doneButton setTintColor:[UIColor blackColor]];
    [self.navigationItem setRightBarButtonItem:doneButton];
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

- (void)dismiss
{
    [self.navigationController dismissModalViewControllerAnimated:YES];
}

@end
