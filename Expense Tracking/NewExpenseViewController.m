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
    
    // Dismiss the keyboard for the 'Description' field when tapping outside of it
    // http://stackoverflow.com/questions/5306240/iphone-dismiss-keyboard-when-touching-outside-of-textfield
    UITapGestureRecognizer *descriptionKeyboardOutsideTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissDescriptionKeyboard)];
    [descriptionKeyboardOutsideTap setCancelsTouchesInView:NO];
    [self.view addGestureRecognizer:descriptionKeyboardOutsideTap];
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

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
//    ExpenseDescriptionViewController *d = [[ExpenseDescriptionViewController alloc] init];
//    Expense *newExpense = [[Expense alloc] init];
//    [newExpense setName:nameTextField.text];
//    [newExpense setAmount:amountTextField.text.doubleValue];
//    [newExpense setTax:taxTextField.text.doubleValue];
//    [d setExpense:newExpense];
//    
//    UIBarButtonItem *b = [[UIBarButtonItem alloc] init];
//    [b setTintColor:[UIColor blackColor]];
//    [b setTitle:@"Back"];
//    [self.navigationItem setBackBarButtonItem:b];
//    [d setDelegate:self];
//    [self.navigationController pushViewController:d animated:YES];
    //[scrollView setContentSize:CGSizeMake(320, 740)];
    [scrollView setContentOffset:CGPointMake(0, 200) animated:YES];
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    return YES;
}

- (void)dismissDescriptionKeyboard
{
    if (descriptionTextField.isFirstResponder) {
        [scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
        [descriptionTextField resignFirstResponder];
    }
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
        dialog = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Please enter a name and an amount" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [dialog show];
        return;
    } else {
        Expense *e = [[Expense alloc] init];
        BOOL result = [e addExpenseWithName:[nameTextField text] 
                                     Amount:[amountTextField text].doubleValue 
                                        Tax:[taxTextField text].doubleValue
                                        Tip:[tipTextField text].doubleValue
                                   Category:[categoryButton.titleLabel text]
                                Description:[descriptionTextField text]];
        
        dialog = [[UIAlertView alloc] initWithTitle:@"Alert" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
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
    CategoriesViewController *c = [[CategoriesViewController alloc] initWithNibName:@"CategoriesViewController" bundle:nil];
    Expense *newExpense = [[Expense alloc] init];
    [newExpense setName:nameTextField.text];
    [newExpense setAmount:amountTextField.text.doubleValue];
    [newExpense setTax:taxTextField.text.doubleValue];
    [c setExpense:newExpense];
    [c setDelegate:self];
    
    UIBarButtonItem *b = [[UIBarButtonItem alloc] init];
    [b setTitle:@"Back"];
    [b setTintColor:[UIColor blackColor]];
    
    [self.navigationItem setBackBarButtonItem:b];
    [self.navigationController pushViewController:c animated:YES];
}

- (void)didFinishSelectingCategoryForExpense:(Expense *)expense
{
    [self populateFieldsWithExpenseData:expense];
    [categoryButton setTitle:expense.category forState:UIControlStateNormal];
}

- (void)populateFieldsWithExpenseData:(Expense *)expense
{
    [nameTextField setText:expense.name];
    [amountTextField setText:[NSString stringWithFormat:@"%f", expense.amount]];
    [taxTextField setText:[NSString stringWithFormat:@"%f", expense.tax]];
    [tipTextField setText:[NSString stringWithFormat:@"%f", expense.tip]];
}

@end
