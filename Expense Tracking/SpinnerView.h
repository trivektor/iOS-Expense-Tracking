//
//  SpinnerView.h
//  Expense Tracking
//
//  Created by Tri Vuong on 9/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SpinnerView : UIView

+ (SpinnerView *)loadSpinnerIntoView:(UIView *)superView;
- (UIImage *)addBackground;
- (void)removeSpinner;

@end
