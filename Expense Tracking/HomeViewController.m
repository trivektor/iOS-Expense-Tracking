//
//  HomeViewController.m
//  Expense Tracking
//
//  Created by Tri Vuong on 8/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "HomeViewController.h"
#import "MonthExpenseViewController.h"
#import "NewExpenseViewController.h"

@interface HomeViewController ()
@end

@implementation HomeViewController

@synthesize options;
@synthesize optionIcons;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        // Add option items to option items array
        // TODO: move this into a model
        self.options = [[NSMutableArray alloc] init];
        [self.options addObject:@"View this month expenses"];
        [self.options addObject:@"Add new expense"];
        [self.options addObject:@"Settings"];
        [self.options addObject:@"About this app"];
        [self.options addObject:@"Feedback"];
        
        self.optionIcons = [[NSMutableArray alloc] init];
        [self.optionIcons addObject:@"calendar.png"];
        [self.optionIcons addObject:@"plus.png"];
        [self.optionIcons addObject:@"settings.png"];
        [self.optionIcons addObject:@"list.png"];
        [self.optionIcons addObject:@"spechbubble.png"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.navigationItem setTitle:@"Expense Tracking"];
}

- (void)viewDidUnload
{
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
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.textLabel.text = [self.options objectAtIndex:[indexPath row]];
    cell.textLabel.font = [UIFont fontWithName:@"Arial" size:16.0];
    [cell.imageView setImage:[UIImage imageNamed:[self.optionIcons objectAtIndex:[indexPath row]]]];
    cell.selectedBackgroundView.backgroundColor = [UIColor orangeColor];
    return cell;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:nil action:nil];
    [self.navigationItem setBackBarButtonItem:backButton];
    
    NSInteger selectedRow = [indexPath row];
    // TODO: is there a better way to do this?
    if (selectedRow == 0) {
        MonthExpenseViewController *a = [[MonthExpenseViewController alloc] init];
        [self.navigationController pushViewController:a animated:YES];
        return;
    }
    
    if (selectedRow == 1) {
        NewExpenseViewController *b = [[NewExpenseViewController alloc] init];
        [self.navigationController pushViewController:b animated:YES];
        return;
    }
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
