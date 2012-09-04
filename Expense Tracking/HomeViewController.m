//
//  HomeViewController.m
//  Expense Tracking
//
//  Created by Tri Vuong on 8/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "HomeViewController.h"
#import "MonthExpenseViewController.h"
#import "ExpensesViewController.h"
#import "MonthsViewController.h"
#import "NewExpenseViewController.h"
#import "AboutViewController.h"
#import "FeedbackViewController.h"
#import "CustomCell.h"

@interface HomeViewController ()
@end

@implementation HomeViewController

@synthesize options;
@synthesize optionIcons;
@synthesize tableView;

- (id)init
{
    if (self) {
        // Custom initialization
        // Add option items to option items array
        // TODO: move this into a model
        self.options = [[NSMutableArray alloc] init];
        [self.options addObject:@"View all expenses"];
        [self.options addObject:@"View expenses by month"];
        [self.options addObject:@"Add new expense"];
        [self.options addObject:@"Settings"];
        [self.options addObject:@"About this app"];
        [self.options addObject:@"Feedback"];
        
        self.optionIcons = [[NSMutableArray alloc] init];
        [self.optionIcons addObject:@"dollar_sign.png"];
        [self.optionIcons addObject:@"calendar.png"];
        [self.optionIcons addObject:@"plus.png"];
        [self.optionIcons addObject:@"settings.png"];
        [self.optionIcons addObject:@"list.png"];
        [self.optionIcons addObject:@"spechbubble.png"];

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
        ExpensesViewController *a = [[ExpensesViewController alloc] init];
        [self.navigationController pushViewController:a animated:YES];
        return;
    }
    
    if (selectedRow == 1) {
        MonthsViewController *m = [[MonthsViewController alloc] init];
        [self.navigationController pushViewController:m animated:YES];
        return;
    }
    
    if (selectedRow == 2) {
        NewExpenseViewController *b = [[NewExpenseViewController alloc] init];
        [self.navigationController pushViewController:b animated:YES];
        return;
    }
    
    if (selectedRow == 4) {
        AboutViewController *o = [[AboutViewController alloc] init];
        [self.navigationController pushViewController:o animated:YES];
        return;
    }
    
    if (selectedRow == 5) {
        FeedbackViewController *f = [[FeedbackViewController alloc] init];
        [self.navigationController pushViewController:f animated:YES];
        return;
    }
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
