//
//  ExpenseDescriptionViewController.m
//  Expense Tracking
//
//  Created by Tri Vuong on 9/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ExpenseDescriptionViewController.h"

@interface ExpenseDescriptionViewController ()

@end

@implementation ExpenseDescriptionViewController

@synthesize expense;

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
    [self.navigationItem setTitle:@"Add Description"];
    [self.view setBackgroundColor:[UIColor clearColor]];
    [descriptionTextView becomeFirstResponder];
    
    UIBarButtonItem *finishDescriptionButton = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:self action:nil];
    [finishDescriptionButton setImage:[UIImage imageNamed:@"done_icon.png"]];
    [finishDescriptionButton setTintColor:[UIColor blackColor]];
    [self.navigationItem setRightBarButtonItem:finishDescriptionButton];
}

- (void)viewDidUnload
{
    descriptionTextView = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
