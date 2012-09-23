//
//  ReceiptsViewController.m
//  Expense Tracking
//
//  Created by Tri Vuong on 9/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ReceiptsViewController.h"

@interface ReceiptsViewController ()

@end

@implementation ReceiptsViewController

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
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    NSString *docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
