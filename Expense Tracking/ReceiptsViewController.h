//
//  ReceiptsViewController.h
//  Expense Tracking
//
//  Created by Tri Vuong on 9/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReceiptsViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITableViewDelegate, UITableViewDataSource>
{
    
    __weak IBOutlet UITableView *receiptsTable;
}

@property (nonatomic, strong) NSArray *receipts;
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, strong) NSPersistentStoreCoordinator *persistenceStoreCoordinator;

- (void)loadReceipts;
- (void)addReceipt;
- (void)saveReceipt;
- (NSString *)saveReceiptImage:(UIImage *)image;
- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
