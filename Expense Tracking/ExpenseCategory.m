//
//  ExpenseCategory.m
//  Expense Tracking
//
//  Created by Tri Vuong on 9/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ExpenseCategory.h"

@implementation ExpenseCategory

+ (NSArray *)getAll
{
    NSArray *allCategories = [NSArray arrayWithObjects:
                              @"Food",
                              @"Groceries",
                              @"Clothing", 
                              @"Education", 
                              @"Entertainment", 
                              @"Family",
                              @"Gifts",
                              @"Automobile",
                              @"Insurance",
                              @"Phone",
                              @"Personal Care",
                              @"Rent",
                              @"Taxes",
                              @"Utilities",
                              nil];
    return allCategories;
}

@end
