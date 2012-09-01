//
//  NewExpenseViewController.m
//  Expense Tracking
//
//  Created by Tri Vuong on 8/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NewExpenseViewController.h"
#import "Expense.h"

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
    nameTextField.delegate = self;
    amountTextField.delegate = self;
    taxTextField.delegate = self;
    tipTextField.delegate = self;
    descriptionTextField.delegate = self;

    [self.view setBackgroundColor:[UIColor clearColor]];
    [self.navigationItem setTitle:@"Add Expense"];
    
    [addExpenseButton setTitleColor:[UIColor colorWithRed:141/255.0 green:67/255.0 blue:2/255.0 alpha:1] forState:UIControlStateNormal];
    
    scrollView.contentSize = CGSizeMake(320, 550);
//    
//    [addButton.layer setCornerRadius:8.0f];
//    [addButton.layer setMasksToBounds:YES];
//    [addButton.layer setBorderWidth:1.0f];
//    [addButton.layer setBackgroundColor:[UIColor orangeColor].CGColor];
//    [addButton setBackgroundColor:[UIColor orangeColor]];
//    [addButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
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
    nameTextField = nil;
    amountTextField = nil;
    taxTextField = nil;
    tipTextField = nil;
    descriptionTextField = nil;
    addExpenseButton = nil;
    scrollView = nil;
    formBackground = nil;
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

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if ([text isEqual:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

- (IBAction)addExpenseButtonTapped:(id)sender
{
    UIAlertView *dialog;
    
    if (nameTextField.text.length == 0 || amountTextField.text.length == 0) {
        dialog = [[UIAlertView alloc] initWithTitle:@"Alert" 
                                            message:@"Please enter a name and an amount" 
                                           delegate:self 
                                  cancelButtonTitle:@"OK" 
                                  otherButtonTitles:nil];
        [dialog show];
        return;
    } else {
        Expense *e = [[Expense alloc] init];
        BOOL result = [e addExpenseWithName:[nameTextField text] 
                                     Amount:[amountTextField text].doubleValue 
                                        Tax:[taxTextField text].doubleValue
                                        Tip:[tipTextField text].doubleValue
                                Description:[descriptionTextField text]];
        
        dialog = [[UIAlertView alloc] initWithTitle:@"Alert" 
                                            message:nil 
                                           delegate:self 
                                  cancelButtonTitle:@"OK" 
                                  otherButtonTitles:nil];
        
        if (result == YES) {
            [dialog setMessage:@"Expense has been added"];
        } else {
            [dialog setMessage:@"An error occurred while adding expense"];
        }
        
        [dialog show];
    }
}

@end
