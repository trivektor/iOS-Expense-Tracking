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
    sqlite3_stmt *insertStatement;
}

@property (nonatomic, retain) NSString *name;
@property (nonatomic) double amount;
@property (nonatomic) double tax;
@property (nonatomic) double tip;
@property (nonatomic, retain) NSString *description;

- (NSMutableArray *) getAll;

- (Boolean)addExpenseWithName:(NSString *)name Amount:(float)amount Tax:(float)tax Tip:(float)tip Description:(NSString *)description;

- (NSString *)getDocumentDirectory;

@end
