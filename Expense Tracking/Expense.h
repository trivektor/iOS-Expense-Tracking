//
//  Expense.h
//  Expense Tracking
//
//  Created by Tri Vuong on 8/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface Expense : NSObject
{
}

- (void)addNewExpenseToDatabase;
+ (Boolean)addExpenseWithName:(NSString *)name Amount:(float)amount Tax:(float)tax Tip:(float)tip Description:(NSString *)description;

@end
