//
//  NewExpenseViewController.m
//  Expense Tracking
//
//  Created by Tri Vuong on 8/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NewExpenseViewController.h"
#import "Expense.h"
#import "ExpenseCategory.h"

@interface NewExpenseViewController ()

@end

@implementation NewExpenseViewController

@synthesize expenseCategories, selectedCategory;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.expenseCategories = [ExpenseCategory getAll];
        self.selectedCategory = @"";
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
    
    // Set title of navigation bar
    [self.navigationItem setTitle:@"Add Expense"];
    
    // Set the text color of 'Add Expense' button
    [addExpenseButton setTitleColor:[UIColor colorWithRed:141/255.0 green:67/255.0 blue:2/255.0 alpha:1] forState:UIControlStateNormal];
    
    // Create the expense form reset button
    UIBarButtonItem *clearFormButton = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonSystemItemTrash target:self action:@selector(clearExpenseForm)];
    [clearFormButton setTintColor:[UIColor blackColor]];
    [clearFormButton setImage:[UIImage imageNamed:@"trash_icon.png"]];
    [self.navigationItem setRightBarButtonItem:clearFormButton];
    
    // Make the whole form scrollable
    scrollView.contentSize = CGSizeMake(320, 540);
    
    // Set delegate, datasource and hide category picker
    [categoryPicker setDelegate:self];
    [categoryPicker setDataSource:self];
    [categoryPicker setHidden:YES];
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
    categoryPicker = nil;
    categoryButton = nil;
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

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [self.expenseCategories count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [self.expenseCategories objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    self.selectedCategory = [self.expenseCategories objectAtIndex:[categoryPicker selectedRowInComponent:0]];
    [categoryButton setTitle:self.selectedCategory forState:UIControlStateNormal];
}

- (void)clearExpenseForm
{
    [nameTextField setText:@""];
    [amountTextField setText:@""];
    [taxTextField setText:@""];
    [tipTextField setText:@""];
    [categoryButton setTitle:@"Category" forState:UIControlStateNormal];
    [descriptionTextField setText:@""];
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
                                   Category:self.selectedCategory
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

- (IBAction)categoryLabelTapped:(id)sender
{
    [categoryPicker setHidden:![categoryPicker isHidden]];
}

@end
