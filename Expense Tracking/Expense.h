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
    sqlite3 *database;
}

@property (nonatomic) int expenseId;
@property (nonatomic, retain) NSString *name;
@property (nonatomic) double amount;
@property (nonatomic) double tax;
@property (nonatomic) double tip;
@property (nonatomic, retain) NSString *category;
@property (nonatomic, retain) NSString *description;
@property (nonatomic, retain) NSString *createdAt;

+ (NSString *) getDBPath;
- (NSMutableArray *) getAll;
- (NSMutableArray *) findBetweenFirstDate:(NSDate *)firstDate LastDate:(NSDate *)lastDate;
- (NSMutableDictionary *) groupExpensesByCategories;

- (Boolean) addExpenseWithName:(NSString *)name Amount:(float)amount Tax:(float)tax Tip:(float)tip Category:(NSString *)category Description:(NSString *)description;

- (void) deleteExpenseByID:(int)expenseID;

@end
