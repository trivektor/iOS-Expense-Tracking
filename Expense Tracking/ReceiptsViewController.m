//
//  ReceiptsViewController.m
//  Expense Tracking
//
//  Created by Tri Vuong on 9/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ReceiptsViewController.h"
#import "Receipt.h"

@interface ReceiptsViewController ()

@end

@implementation ReceiptsViewController

@synthesize receipts;
@synthesize managedObjectContext = __managedObjectContext;
@synthesize managedObjectModel = __managedObjectModel;
@synthesize persistenceStoreCoordinator = __persistenceStoreCoordinator;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    receiptsTable.delegate = self;
    receiptsTable.dataSource = self;
    [self loadReceipts];
    
    UIBarButtonItem *newReceipt = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"camera_icon.png"] style:UIBarButtonItemStylePlain target:self action:@selector(addReceipt)];
    [newReceipt setTintColor:[UIColor blackColor]];

    [self.navigationItem setTitle:@"Receipts"];
    [self.navigationItem setRightBarButtonItem:newReceipt];
}

- (void)viewWillUnload
{
    [self saveContext];
}

- (void)viewDidUnload
{
    receiptsTable = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)addReceipt
{
    UIImagePickerController *p = [[UIImagePickerController alloc] init];
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        [p setSourceType:UIImagePickerControllerSourceTypeCamera];
    } else {
        [p setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    }
    [p setDelegate:self];
    
    [self presentViewController:p animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    @try {
        UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
        NSString *imagePath = [self saveReceiptImage:image];
        
        Receipt *receipt = [NSEntityDescription insertNewObjectForEntityForName:@"Receipt" inManagedObjectContext:self.managedObjectContext];
        NSError *error;
        
        [receipt setValue:@"Receipt" forKey:@"name"];
        [receipt setValue:imagePath forKey:@"photo"];
        [receipt setValue:[NSDate date] forKey:@"created_at"];
        
        if ([self.managedObjectContext save:&error]) {
            NSLog(@"Receipt has been saved successfully");
        }
    }
    @catch (NSException *exception) {
        NSLog(@"%@", exception.description);
    }
    @finally {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (NSString *)saveReceiptImage:(UIImage *)image
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *receiptsDirectoryPath = [documentsDirectory stringByAppendingPathComponent:@"ExpenseTrackingReceipts"];
    
    NSTimeInterval timeStamp = [[NSDate date] timeIntervalSince1970];
    // NSTimeInterval is defined as double
    NSNumber *timeStampObj = [NSNumber numberWithDouble: timeStamp];
    
    NSString *pngFilePath = [NSString stringWithFormat:@"%@/%@.png", receiptsDirectoryPath, timeStampObj];
    NSData *data1 = [NSData dataWithData:UIImagePNGRepresentation(image)];
    [data1 writeToFile:pngFilePath atomically:YES];
    
    return pngFilePath;
}

- (void)loadReceipts
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Receipt" inManagedObjectContext:self.managedObjectContext];
    
    [fetchRequest setEntity:entity];
    
    NSError *error = nil;
    
    self.receipts = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
}

- (void)saveReceipt
{
    
}

- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    
    if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.receipts.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [receiptsTable dequeueReusableCellWithIdentifier:@"Cell"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    
    Receipt *r = [self.receipts objectAtIndex:[indexPath row]];
    
    cell.textLabel.text = @"Receipt";
    cell.imageView.image = [UIImage imageWithData:[NSData dataWithContentsOfFile:r.photo]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (NSManagedObjectContext *)managedObjectContext
{
    if (__managedObjectContext != nil) {
        return __managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistenceStoreCoordinator];
    
    if (coordinator != nil) {
        __managedObjectContext = [[NSManagedObjectContext alloc] init];
        [__managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    
    return __managedObjectContext;
}

- (NSManagedObjectModel *)managedObjectModel
{
    if (__managedObjectModel != nil) {
        return __managedObjectModel;
    }
    
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"ExpenseTracking" withExtension:@"momd"];
    
    __managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    
    return __managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistenceStoreCoordinator
{
    if (__persistenceStoreCoordinator != nil) {
        return __persistenceStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"ExpenseTracking2.sqlite"];
    
    NSError *error = nil;
    
    __persistenceStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:self.managedObjectModel];
    
    if (![__persistenceStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return __persistenceStoreCoordinator;
}

- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
