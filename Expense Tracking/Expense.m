//
//  Expense.m
//  Expense Tracking
//
//  Created by Tri Vuong on 8/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Expense.h"

@implementation Expense

@synthesize name, amount, tax, tip, description, createdAt;

- (Boolean)addExpenseWithName:(NSString *)ename Amount:(float)eamount Tax:(float)etax Tip:(float)etip Description:(NSString *)edescription;
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *dbPath = [documentsDirectory stringByAppendingPathComponent:@"ExpenseTracking.sqlite"];

    if (sqlite3_open(dbPath.UTF8String, &database) == SQLITE_OK) {
        NSLog(@"successfully opened database at the provided database path");
        
        if (insertStatement == nil) {
            NSLog(@"inserting new expense");
            
            const char *sql = "INSERT INTO expenses(id, name, amount, tax, tip, category, description, created_at, updated_at) VALUES(NULL, ?, ?, ?, ?, ?, ?, datetime('now'), datetime('now'))";
            
            if (sqlite3_prepare_v2(database, sql, -1, &insertStatement, NULL) != SQLITE_OK) {
                NSLog(@"Error white creating insert statement");
                NSAssert1(0, @"Error white creating insert statement. '%s'", sqlite3_errmsg(database));
            }
            sqlite3_bind_text(insertStatement, 1, ename.UTF8String, -1, SQLITE_TRANSIENT);
            sqlite3_bind_double(insertStatement, 2, eamount);
            sqlite3_bind_double(insertStatement, 3, etax);
            sqlite3_bind_double(insertStatement, 4, etip);
            sqlite3_bind_text(insertStatement, 6, edescription.UTF8String, -1, SQLITE_TRANSIENT);
            
            if (sqlite3_step(insertStatement) == SQLITE_DONE) {
                NSLog(@"New expense has been inserted successfully");
            }
            sqlite3_finalize(insertStatement);
            sqlite3_close(database);
            return YES;
        }
    }
    NSLog(@"cannot open database file at the database path provided");
    return NO;
}

- (NSMutableArray *) getAll
{
    NSMutableArray *expensesArray = [[NSMutableArray alloc] init];
    
    @try {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString *dbPath = [documentsDirectory stringByAppendingPathComponent:@"ExpenseTracking.sqlite"];
        
        NSFileManager *fileManager = [NSFileManager defaultManager];
        BOOL success = [fileManager fileExistsAtPath:dbPath];
        
        if (!success) 
        {
            NSLog(@"Cannot locate database file");
        }
        
        if (!(sqlite3_open([dbPath UTF8String], &database) == SQLITE_OK))
        {
            NSLog(@"An error has occured");
        }
        
        const char *sql = "SELECT * FROM expenses ORDER BY created_at DESC";
        sqlite3_stmt *selectStatement;
        
        if (sqlite3_prepare(database, sql, -1, &selectStatement, NULL) != SQLITE_OK)
        {
            NSLog(@"Problem with prepare statement");
        }
        
        while (sqlite3_step(selectStatement) == SQLITE_ROW) 
        {
            Expense *expense = [[Expense alloc] init];
            if ((char*)sqlite3_column_text(selectStatement, 1) != NULL)
            {
                expense.name = [NSString stringWithUTF8String:(char*)sqlite3_column_text(selectStatement, 1)];
            } else {
                expense.name = @"Untitled expense";
            }
            expense.amount = sqlite3_column_double(selectStatement, 2);
            expense.tax = sqlite3_column_double(selectStatement, 3);
            expense.tip = sqlite3_column_double(selectStatement, 4);
            //expense.description = [NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatement, 5)];
            expense.createdAt = [NSString stringWithUTF8String:(char *) sqlite3_column_text(selectStatement, 6)];
            [expensesArray addObject:expense];
        }
    }
    @catch (NSException *exception) {
        NSLog(@"An exception occured: %@", [exception reason]);
    }
    @finally {
        return expensesArray;
    }
}

@end
