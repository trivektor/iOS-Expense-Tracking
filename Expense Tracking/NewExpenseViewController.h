//
//  NewExpenseViewController.h
//  Expense Tracking
//
//  Created by Tri Vuong on 8/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "CategoriesViewController.h"
#import "ExpenseDescriptionViewController.h"

@interface NewExpenseViewController : UIViewController <UITextFieldDelegate, UIScrollViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource, CategoriesViewControllerDelegate>
{
    __weak IBOutlet UIImageView *formBackground;
    __weak IBOutlet UIScrollView *scrollView;
    __weak IBOutlet UITextField *nameTextField;
    __weak IBOutlet UITextField *amountTextField;
    __weak IBOutlet UITextField *taxTextField;
    __weak IBOutlet UITextField *tipTextField;
    __weak IBOutlet UIButton *categoryButton;
    __weak IBOutlet UITextView *descriptionTextField;
    __weak IBOutlet UIButton *addExpenseButton;
}

@property (nonatomic, retain) NSArray *expenseCategories;
@property (nonatomic, retain) NSString *selectedCategory;

- (void)clearExpenseForm;
- (IBAction)addExpenseButtonTapped:(id)sender;
- (IBAction)categoryLabelTapped:(id)sender;

@end
