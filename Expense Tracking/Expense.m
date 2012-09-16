//
//  Expense.m
//  Expense Tracking
//
//  Created by Tri Vuong on 8/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Expense.h"

@implementation Expense

@synthesize expenseId, name, amount, tax, tip, category, description, createdAt;

- (Boolean)addExpenseWithName:(NSString *)ename Amount:(float)eamount Tax:(float)etax Tip:(float)etip Category:(NSString *)ecategory Description:(NSString *)edescription;
{
    NSString *dbPath = [Expense getDBPath];
    
    if (sqlite3_open(dbPath.UTF8String, &database) == SQLITE_OK) {
        NSLog(@"successfully opened database at the provided database path");
        
        sqlite3_stmt *insertStatement;
        char *sql = "INSERT INTO expenses(id, name, amount, tax, tip, category, description, created_at, updated_at) VALUES(NULL, ?, ?, ?, ?, ?, ?, datetime('now'), datetime('now'))";
        
        if (sqlite3_prepare_v2(database, sql, -1, &insertStatement, NULL) != SQLITE_OK) {
            NSLog(@"Error white creating insert statement");
            NSAssert1(0, @"Error white creating insert statement. '%s'", sqlite3_errmsg(database));
        }
        sqlite3_bind_text(insertStatement, 1, ename.UTF8String, -1, SQLITE_TRANSIENT);
        sqlite3_bind_double(insertStatement, 2, eamount);
        sqlite3_bind_double(insertStatement, 3, etax);
        sqlite3_bind_double(insertStatement, 4, etip);
        sqlite3_bind_text(insertStatement, 5, ecategory.UTF8String, -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(insertStatement, 6, edescription.UTF8String, -1, SQLITE_TRANSIENT);
        
        if (sqlite3_step(insertStatement) == SQLITE_DONE) {
            NSLog(@"New expense has been inserted successfully");
        }
        sqlite3_finalize(insertStatement);
        sqlite3_close(database);
        return YES;
    }
    NSLog(@"cannot open database file at the database path provided");
    return NO;
}

- (NSMutableArray *) getAll
{
    NSMutableArray *expensesArray = [[NSMutableArray alloc] init];
    
    @try {
        NSString *dbPath = [Expense getDBPath];
        
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
        
        char *sql = "SELECT * FROM expenses ORDER BY created_at DESC";
        sqlite3_stmt *selectStatement;
        
        if (sqlite3_prepare(database, sql, -1, &selectStatement, NULL) != SQLITE_OK)
        {
            NSLog(@"Problem with prepare statement");
        }
        
        while (sqlite3_step(selectStatement) == SQLITE_ROW) 
        {
            Expense *expense = [[Expense alloc] init];
            
            // Expense ID
            expense.expenseId = sqlite3_column_int(selectStatement, 0);

            // Expense name
            if ((char *)sqlite3_column_text(selectStatement, 1) != NULL)
            {
                expense.name = [NSString stringWithUTF8String:(char*)sqlite3_column_text(selectStatement, 1)];
            } else {
                expense.name = @"Untitled expense";
            }
            
            // Expense amount
            expense.amount = sqlite3_column_double(selectStatement, 2);
            
            // Expense tax
            expense.tax = sqlite3_column_double(selectStatement, 3);
            
            // Expense tip
            expense.tip = sqlite3_column_double(selectStatement, 4);
            
            // Expense category
            if ((char *) sqlite3_column_text(selectStatement, 5)) {
                expense.category = [NSString stringWithUTF8String:(char *) sqlite3_column_text(selectStatement, 5)];
            } else {
                expense.category = @"Uncategorized";
            }
            
            // Expense description
            if ((char *)sqlite3_column_text(selectStatement, 6)) {
                expense.description = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStatement, 6)];
            } else {
                expense.description = @"";
            }
            
            // Expense date
            expense.createdAt = [NSString stringWithUTF8String:(char*)sqlite3_column_text(selectStatement, 7)];
            
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

- (NSMutableArray *) findBetweenFirstDate:(NSDate *)firstDate LastDate:(NSDate *)lastDate;
{
    NSMutableArray *expensesArray = [[NSMutableArray alloc] init];
    
    NSString *dbPath = [Expense getDBPath];
    
    if (sqlite3_open(dbPath.UTF8String, &database) == SQLITE_OK) {
        char *sql = "SELECT * FROM expenses WHERE created_at >= ? AND created_at < ? ORDER BY created_at DESC";
        sqlite3_stmt *selectStatement;
                
        if (sqlite3_prepare_v2(database, sql, -1, &selectStatement, NULL) == SQLITE_OK) {
            sqlite3_bind_text(selectStatement, 1, [firstDate.description UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(selectStatement, 2, [lastDate.description UTF8String], -1, SQLITE_TRANSIENT);

            while (sqlite3_step(selectStatement) == SQLITE_ROW) 
            {
                Expense *expense = [[Expense alloc] init];
                expense.expenseId = sqlite3_column_int(selectStatement, 0);
                if ((char*)sqlite3_column_text(selectStatement, 1) != NULL)
                {
                    expense.name = [NSString stringWithUTF8String:(char*)sqlite3_column_text(selectStatement, 1)];
                } else {
                    expense.name = @"Untitled expense";
                }
                expense.amount = sqlite3_column_double(selectStatement, 2);
                expense.tax = sqlite3_column_double(selectStatement, 3);
                expense.tip = sqlite3_column_double(selectStatement, 4);
                expense.description = ((char*)sqlite3_column_text(selectStatement, 5)) ? 
                [NSString stringWithUTF8String:(char*)sqlite3_column_text(selectStatement, 5)] : @"";
                expense.createdAt = [NSString stringWithUTF8String:(char*)sqlite3_column_text(selectStatement, 7)];
                [expensesArray addObject:expense];
                
            }
        }
    }
    
    return expensesArray;
}

- (void) deleteExpenseByID:(int)expenseID 
{
    NSString *dbPath = [Expense getDBPath];
    
    if (sqlite3_open(dbPath.UTF8String, &database) == SQLITE_OK) {
        char *sql = "DELETE FROM expenses WHERE id = ?";
        sqlite3_stmt *deleteStatement;
        
        if (sqlite3_prepare_v2(database, sql, -1, &deleteStatement, NULL) != SQLITE_OK)
        {
            NSLog(@"Problem while preparing delete statement");
        }
        
        sqlite3_bind_int(deleteStatement, 1, expenseID);
        sqlite3_step(deleteStatement);
        sqlite3_finalize(deleteStatement);
        sqlite3_close(database);
    }
}

- (NSMutableDictionary *) groupExpensesByCategories
{
    NSString *dbPath = [Expense getDBPath];
    NSMutableDictionary *categoryExpenses = [[NSMutableDictionary alloc] init];
    
    if (sqlite3_open(dbPath.UTF8String, &database) == SQLITE_OK) {
        char *sql = "SELECT category, total(amount) FROM expenses GROUP BY category";
        sqlite3_stmt *selectStatement;
        
        if (sqlite3_prepare_v2(database, sql, -1, &selectStatement, NULL) == SQLITE_OK) {
            while (sqlite3_step(selectStatement) == SQLITE_ROW) {
                
                NSNumber *_amount = [[NSNumber alloc] initWithDouble:sqlite3_column_double(selectStatement, 1)];
                NSString *_category;
                
                if (sqlite3_column_text(selectStatement, 0) == NULL) {
                    _category = @"Uncategorized";
                } else {
                    _category = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStatement, 0)];
                    
                    if (_category.length == 0) _category = @"Uncategorized";
                }
                
                [categoryExpenses setValue:_amount forKey:_category];
            }
        }
    }
    
    return categoryExpenses;
}

+ (NSString *)getDBPath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *dbPath = [documentsDirectory stringByAppendingPathComponent:@"ExpenseTracking.sqlite"];
    return dbPath;
}

@end
