//
//  NewExpenseViewController.m
//  Expense Tracking
//
//  Created by Tri Vuong on 8/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NewExpenseViewController.h"

@interface NewExpenseViewController ()

@end

@implementation NewExpenseViewController

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
    [self.view setBackgroundColor:[UIColor clearColor]];
    [self.navigationItem setTitle:@"Add Expense"];
    
    UIImageView *bg = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 299, 396)];
    bg.image = [UIImage imageNamed:@"envelope_form.png"];
    [self.view addSubview:bg];
    [self.view sendSubviewToBack:bg];
    
    UIImage *addButtonImage = [UIImage imageNamed:@"yellow_btn.png"];
    [addButton setBackgroundImage:addButtonImage forState:UIControlStateNormal];
    [addButton setB
}

- (void)viewDidUnload
{
    nameField = nil;
    amountField = nil;
    taxField = nil;
    tipField = nil;
    categoryField = nil;
    descriptionField = nil;
    addButton = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
