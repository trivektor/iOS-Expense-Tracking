//
//  ReceiptViewController.h
//  Expense Tracking
//
//  Created by Tri Vuong on 9/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Receipt.h"

@interface ReceiptViewController : UIViewController

@property (nonatomic, strong) Receipt *receipt;

- (void)dismiss;

@end
