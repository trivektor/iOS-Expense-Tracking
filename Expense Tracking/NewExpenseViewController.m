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
    
    [addButton.layer setCornerRadius:8.0f];
    [addButton.layer setMasksToBounds:YES];
    [addButton.layer setBorderWidth:1.0f];
    [addButton.layer setBackgroundColor:[UIColor orangeColor].CGColor];
    [addButton setBackgroundColor:[UIColor orangeColor]];
    [addButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
//    [addButton.layer setBackgroundColor:[UIColor orangeColor].CGColor];
//    [addButton setTintColor:[UIColor orangeColor]];
//    [addButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
//    gradientLayer.frame = addButton.layer.bounds;
//    gradientLayer.colors = [NSArray arrayWithObjects:
//                            [UIColor colorWithHue:0x45/255.0 saturation:0x63/255.0 brightness:0x99/255.0 alpha:1.0].CGColor,
//                            [UIColor colorWithHue:0x39/255.0 saturation:0x84/255.0 brightness:0x96/255.0 alpha:1.0].CGColor,
//                            nil];
//    gradientLayer.cornerRadius = addButton.layer.cornerRadius;
//    [addButton.layer addSublayer:gradientLayer];
//    [addButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    //[addButton.layer setBorderColor:[UIColor ].CGColor];
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
