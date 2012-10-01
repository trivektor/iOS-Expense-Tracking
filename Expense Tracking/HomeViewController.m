//
//  HomeViewController.m
//  Expense Tracking
//
//  Created by Tri Vuong on 8/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "HomeViewController.h"
#import "ExpensesViewController.h"
#import "MonthsViewController.h"
#import "MonthsListViewController.h"
#import "ExpensesByCategoryViewController.h"
#import "NewExpenseViewController.h"
#import "ReceiptsViewController.h"
#import "SignupViewController.h"
#import "FeedbackViewController.h"
#import "ServerUploadViewController.h"
#import "LoginViewController.h"
#import "KeyChainItemWrapper.h"
#import "AFHTTPClient.h"
#import "AFHTTPRequestOperation.h"
#import "CustomCell.h"

@interface HomeViewController ()
@end

@implementation HomeViewController

@synthesize options, optionIcons, tableView;
@synthesize managedObjectContext = __managedObjectContext;
@synthesize managedObjectModel = __managedObjectModel;
@synthesize persistenceStoreCoordinator = __persistenceStoreCoordinator;

- (id)init
{
    if (self) {
        // Custom initialization
        // Add option items to option items array
        // TODO: move this into a model
        self.options = [[NSMutableArray alloc] initWithObjects:
                        @"View all expenses",
                        @"View expenses by month",
                        @"View expenses by category",
                        @"Add new expense",
                        @"Receipts",
                        @"Upload to server",
                        @"Settings",
                        @"Feedback",
                        nil];
        
        self.optionIcons = [[NSMutableArray alloc] initWithObjects:
                            @"dollar_sign.png",
                            @"calendar.png",
                            @"charts_icon.png",
                            @"plus.png",
                            @"receipt_icon.png",
                            @"upload_icon.png",
                            @"gear.png",
                            @"speaker_icon.png",
                            nil];
    }
    return self;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    return [self init];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization        
    }
    return self;
}

- (void)loadView
{
    UIView *mainView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
    self.view = mainView;
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(13, 10, 294, 397) style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:self.tableView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.navigationItem setTitle:@"Expense Tracking"];
    [self.view setBackgroundColor:[UIColor clearColor]];
    //[self.tableView setBackgroundColor:[[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"envelope_form.png"]]];
    UIImageView *backgroundImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"envelope_form.png"]];
    [backgroundImage setFrame:self.tableView.frame];
    [self.tableView setBackgroundView:backgroundImage];
    [self.tableView setScrollEnabled:NO];
    
    UINib *nib = [UINib nibWithNibName:@"CustomCell" bundle:nil];
    
    [self.tableView registerNib:nib forCellReuseIdentifier:@"CustomCell"];


}

- (void)viewDidUnload
{
    self.tableView = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.options count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CustomCell";
    CustomCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {
        cell = [[CustomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.textLabel.text = [self.options objectAtIndex:[indexPath row]];
    cell.textLabel.font = [UIFont fontWithName:@"Arial" size:14.0];
    cell.textLabel.textColor = [UIColor colorWithHue:0.0/255.0 saturation:0.0/255.0 brightness:76.0/255.0 alpha:1.0];
    [cell.imageView setImage:[UIImage imageNamed:[self.optionIcons objectAtIndex:[indexPath row]]]];
    cell.selectedBackgroundView.backgroundColor = [UIColor orangeColor];
    cell.backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 275, 44)];
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
//    UIView *bgColorView = [[UIView alloc] init];
//    [bgColorView setBackgroundColor:[UIColor grayColor]];
//    [cell setSelectedBackgroundView:bgColorView];

    return cell;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:nil action:nil];
    [backButton setTintColor:[UIColor blackColor]];
    [self.navigationItem setBackBarButtonItem:backButton];
    
    NSInteger selectedRow = [indexPath row];
    // TODO: is there a better way to do this?
    if (selectedRow == 0) {
        Expense *dao = [[Expense alloc] init];
        ExpensesViewController *a = [[ExpensesViewController alloc] initWithExpenses:[dao getAll]];
        [self.navigationController pushViewController:a animated:YES];
        return;
    }
    
    if (selectedRow == 1) {
        MonthsViewController *m = [[MonthsViewController alloc] initWithSelectedDate:[NSDate date]];
        [self.navigationController pushViewController:m animated:YES];
        return;
//        MonthsListViewController *m = [[MonthsListViewController alloc] init];
//        [self.navigationController pushViewController:m animated:YES];
//        return;
    }
    
    if (selectedRow == 2) {
        ExpensesByCategoryViewController *e = [[ExpensesByCategoryViewController alloc] init];
        [self.navigationController pushViewController:e animated:YES];
        return;
    }
    
    if (selectedRow == 3) {
        NewExpenseViewController *b = [[NewExpenseViewController alloc] init];
        [self.navigationController pushViewController:b animated:YES];
        return;
    }
    
    if (selectedRow == 4) {
        ReceiptsViewController *r = [[ReceiptsViewController alloc] init];
        //r.managedObjectContext = self.managedObjectContext;
        [self.navigationController pushViewController:r animated:YES];
        return;
    }
    
    if (selectedRow == 5) {
        [self validateAuthenticationToken];
        return;
    }
        
    if (selectedRow == 6) {
    }
    
    if (selectedRow == 7) {
        FeedbackViewController *f = [[FeedbackViewController alloc] init];
        [self.navigationController pushViewController:f animated:YES];
        return;
    }
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (BOOL)validateAuthenticationToken
{
    NSURL *signinURL = [NSURL URLWithString:@"http://thawing-oasis-5679.herokuapp.com/api/tokens/validate.json"];
    
    KeychainItemWrapper *keychain = [[KeychainItemWrapper alloc] initWithIdentifier:@"ExpenseTrackingKeychain" accessGroup:nil];
    
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:signinURL];
    
    NSMutableDictionary *userParams = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                       [keychain objectForKey:(__bridge id)kSecAttrAccount], @"token",
                                       nil];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   userParams, @"user",
                                   nil];
    
    NSMutableURLRequest *postRequest = [httpClient requestWithMethod:@"POST" path:signinURL.absoluteString parameters:params];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:postRequest];
    
    [operation setCompletionBlockWithSuccess:
     ^(AFHTTPRequestOperation *operation, id responseObject) {
         NSString *response = [operation responseString];
         
         NSDictionary *json = [NSJSONSerialization JSONObjectWithData:[response dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];

         if ([[json valueForKey:@"success"] intValue] == 1) {
             ServerUploadViewController *s = [[ServerUploadViewController alloc] init];
             [self.navigationController pushViewController:s animated:YES];
         } else {
             LoginViewController *l = [[LoginViewController alloc] init];
             [self.navigationController pushViewController:l animated:YES];
         }
     }
                                     failure:
     ^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"error: %@", [operation error]);
     }];
    
    //self.spinnerView = [SpinnerView loadSpinnerIntoView:self.view];
    [operation start];
}

@end
