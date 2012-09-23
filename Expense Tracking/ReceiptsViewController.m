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

@synthesize managedObjectContext, managedObjectModel, persistenceStoreCoordinator;

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
    
    UIBarButtonItem *newReceipt = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"camera_icon.png"] style:UIBarButtonItemStylePlain target:self action:@selector(addReceipt)];
    [newReceipt setTintColor:[UIColor blackColor]];

    [self.navigationItem setTitle:@"Receipts"];
    [self.navigationItem setRightBarButtonItem:newReceipt];
}

- (void)viewDidUnload
{
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
        
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        NSManagedObjectContext *context = [self managedObjectContext];
        NSEntityDescription *entity = [NSEntityDescription insertNewObjectForEntityForName:@"Receipt" inManagedObjectContext:self.managedObjectContext];
        [fetchRequest setEntity:entity];
        NSError *error;
        
        //    [receipt setValue:@"Receipt" forKey:@"name"];
        //    [receipt setValue:imagePath forKey:@"image"];
        //    [receipt setValue:[NSDate date] forKey:@"created_at"];
        
        //    if ([context save:&error]) {
        //        NSLog(@"Receipt has been saved successfully");
        //    }
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

- (void)saveReceipt
{
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
