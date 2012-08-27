//
//  AppDelegate.m
//  Expense Tracking
//
//  Created by Tri Vuong on 8/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"
#import "HomeViewController.h"

@implementation AppDelegate

@synthesize window = _window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [self createEditableCopyOfDatabaseIfNeeded];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    HomeViewController *h = [[HomeViewController alloc] init];
    UINavigationController *mainNavController = [[UINavigationController alloc] initWithRootViewController:h];
    [mainNavController.navigationBar setBackgroundImage:[UIImage imageNamed:@"header.jpg"] forBarMetrics:nil];

    [self.window setRootViewController:mainNavController];
    [self.window setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"wood-wallpaper.jpg"]]];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void) createEditableCopyOfDatabaseIfNeeded
{
    NSError *err=nil;
    
    NSFileManager *fileMgr = [NSFileManager defaultManager];
    NSString *dbpath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"Expense-Tracking.sqlite"];
    
    NSString *copydbpath = [self.getDocumentDirectory stringByAppendingPathComponent:@"Expense-Tracking.sqlite"];
    [fileMgr removeItemAtPath:copydbpath error:&err];
    
    if(![fileMgr copyItemAtPath:dbpath toPath:copydbpath error:&err])
    {
        UIAlertView *tellErr = [[UIAlertView alloc] initWithTitle:@"Alert" 
                                                          message:@"Unable to copy database." 
                                                         delegate:self 
                                                cancelButtonTitle:@"OK" 
                                                otherButtonTitles:nil];
        [tellErr show];
    }
//    BOOL success;
//    NSFileManager *fileManager = [NSFileManager defaultManager];
//    NSError *error;
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *expensesDirectory = [paths objectAtIndex:0];
//    NSString *writableDBPath = [expensesDirectory stringByAppendingPathComponent:@"Expense-Tracking.sqlite"];
//    success = [fileManager fileExistsAtPath:writableDBPath];
//    NSLog([[NSBundle mainBundle] resourcePath]);
//    if (success) return;
//    NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"Expense-Tracking.sqlite"];
//    success = [fileManager copyItemAtPath:defaultDBPath toPath:writableDBPath error:&error];
//    if (!success) {
//        NSLog(@"Failed to create writable database with message '%C'", [error localizedDescription]);
//    }
    
}
                                
- (NSString *) getDocumentDirectory{
    NSFileManager *fileMgr = [NSFileManager defaultManager];
    NSString *homeDir = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    return homeDir;
}

- (NSString *) getDBPath {
	//Search for standard documents using NSSearchPathForDirectoriesInDomains
	//First Param = Searching the documents directory
	//Second Param = Searching the Users directory and not the System
	//Expand any tildes and identify home directories.
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory , NSUserDomainMask, YES);
	NSString *documentsDir = [paths objectAtIndex:0];
	return [documentsDir stringByAppendingPathComponent:@"Expense-Tracking.sqlite"];
}

@end
