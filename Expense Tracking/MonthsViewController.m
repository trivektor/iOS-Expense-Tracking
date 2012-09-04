//
//  MonthsViewController.m
//  Expense Tracking
//
//  Created by Tri Vuong on 9/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MonthsViewController.h"

@interface MonthsViewController ()

@end

@implementation MonthsViewController

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
    [self.navigationItem setTitle:@"Select Month"];
    [viewExpensesButton setTitleColor:[UIColor colorWithRed:141/255.0 green:67/255.0 blue:2/255.0 alpha:1] forState:UIControlStateNormal];
}

- (void)viewDidUnload
{
    monthPicker = nil;
    viewExpensesButton = nil;
    viewExpensesButton = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)viewExpensesButtonTapped:(id)sender
{
    NSLog(@"selecting a month");
    NSLog(@"%@", [monthPicker date]);
}

@end
