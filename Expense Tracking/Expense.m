//
//  Expense.m
//  Expense Tracking
//
//  Created by Tri Vuong on 8/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Expense.h"

@implementation Expense

@synthesize name, amount, tax, tip, description;

- (Boolean)addExpenseWithName:(NSString *)ename Amount:(float)eamount Tax:(float)etax Tip:(float)etip Description:(NSString *)edescription;
{
    NSString *dbPath = [self.getDocumentDirectory stringByAppendingPathComponent:@"Expense-Tracking.sqlite"];
    if (sqlite3_open(dbPath.UTF8String, &database) == SQLITE_OK) {
        NSLog(@"successfully opened database at the provided database path");
        
        if (insertStatement == nil) {
            NSLog(@"inserting new expense");
            
            const char *sql = "insert into expenses(id, name, amount, tax, tip, category, description) values(NULL, ?, ?, ?, ?, ?, ?)";
            
            if (sqlite3_prepare_v2(database, sql, -1, &insertStatement, NULL) != SQLITE_OK) {
                NSLog(@"Error white creating insert statement");
                NSAssert1(0, @"Error white creating insert statement. '%s'", sqlite3_errmsg(database));
            }
            
            sqlite3_bind_text(insertStatement, 1, ename.UTF8String, -1, SQLITE_TRANSIENT);
            //sqlite3_bind_double(insertStatement, 2, eamount);
            //sqlite3_bind_double(insertStatement, 3, etax);
            //sqlite3_bind_double(insertStatement, 4, etip);
            //sqlite3_bind_text(insertStatement, 6, edescription.UTF8String, -1, SQLITE_TRANSIENT);
            //sqlite3_finalize(insertStatement);
            
            if (sqlite3_step(insertStatement) == SQLITE_OK) {
                sqlite3_finalize(insertStatement);
                sqlite3_close(database);
                NSLog(@"new expense inserted fine");
                return YES;
            } else {
                NSLog(@"new expense was not inserted");
                NSLog(@"sqlite3_step error: '%s'", sqlite3_errmsg(database));
                return NO;  
            }
        }
        NSLog(@"insert statement is not nil");
    }
    NSLog(@"cannot open database file at the database path provided");
    return NO;
}

- (NSMutableArray *) getAll
{
    NSMutableArray *expensesArray = [[NSMutableArray alloc] init];
    
    @try {
        NSFileManager *fileManager = [NSFileManager defaultManager];
        NSString *dbPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"Expense-Tracking.sqlite"];
        BOOL success = [fileManager fileExistsAtPath:dbPath];
        
        if (!success) 
        {
            NSLog(@"Cannot locate database file");
        }
        
        if (!(sqlite3_open([dbPath UTF8String], &database) == SQLITE_OK))
        {
            NSLog(@"An error has occured");
        }
        
        const char *sql = "SELECT * FROM expenses";
        sqlite3_stmt *sqlStatement;
        
        if (sqlite3_prepare(database, sql, -1, &sqlStatement, NULL) != SQLITE_OK)
        {
            NSLog(@"Problem with prepare statement");
        }
        
        while (sqlite3_step(sqlStatement) == SQLITE_ROW) 
        {
            Expense *expense = [[Expense alloc] init];
            expense.name = [NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatement, 1)];
            expense.amount = sqlite3_column_double(sqlStatement, 2);
            expense.tax = sqlite3_column_double(sqlStatement, 3);
            expense.tip = sqlite3_column_double(sqlStatement, 4);
            //expense.description = [NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatement, 5)];
            [expensesArray addObject:expense];
        }
    }
    @catch (NSException *exception) {
        NSLog(@"An exception occured: %@", [exception reason]);
    }
    @finally {
        NSLog(@"%i", [expensesArray count]);
        return expensesArray;
    }
}

- (NSString *) getDocumentDirectory{
    NSFileManager *fileMgr = [NSFileManager defaultManager];
    NSString *homeDir = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    return homeDir;
}

@end
