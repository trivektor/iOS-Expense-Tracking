//
//  Expense.m
//  Expense Tracking
//
//  Created by Tri Vuong on 8/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Expense.h"

@implementation Expense

static sqlite3 *database = nil;
static sqlite3_stmt *insertStatement = nil;

+ (Boolean)addExpenseWithName:(NSString *)name Amount:(float)amount Tax:(float)tax Tip:(float)tip Description:(NSString *)description;
{
    NSString *dbPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"Expense-Tracking.sqlite"];
    if (sqlite3_open(dbPath.UTF8String, &database) == SQLITE_OK) {
        NSLog(@"successfully opened database at the provided database path");
        
        if (insertStatement == nil) {
            NSLog(@"inserting new expense");
            
            const char *sql = "insert into expenses(name, amount, tax, tip, description) values(?, ?, ?, ?, ?)";
            
            if (sqlite3_prepare_v2(database, sql, -1, &insertStatement, NULL) != SQLITE_OK) {
                NSAssert1(0, @"Error white creating insert statement. '%s'", sqlite3_errmsg(database));
            }
            
            sqlite3_bind_text(insertStatement, 1, name.UTF8String, -1, SQLITE_TRANSIENT);
            sqlite3_bind_double(insertStatement, 2, amount);
            sqlite3_bind_double(insertStatement, 3, tax);
            sqlite3_bind_double(insertStatement, 4, tip);
            sqlite3_bind_text(insertStatement, 5, description.UTF8String, -1, SQLITE_TRANSIENT);
            
            sqlite3_reset(insertStatement);
            return YES;
        }
        NSLog(@"insert statement is not nil");
    }
    NSLog(@"cannot open database file at the database path provided");
    return NO;
}

@end
