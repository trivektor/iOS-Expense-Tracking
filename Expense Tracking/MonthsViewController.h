//
//  MonthsViewController.h
//  Expense Tracking
//
//  Created by Tri Vuong on 9/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MonthsViewController : UIViewController
{
    __weak IBOutlet UIDatePicker *monthPicker;
    __weak IBOutlet UIButton *viewExpensesButton;
}

- (IBAction)viewExpensesButtonTapped:(id)sender;

@end
