//
//  MonthsListViewController.m
//  Expense Tracking
//
//  Created by Tri Vuong on 9/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MonthsListViewController.h"
#import "Month.h"

@interface MonthsListViewController ()

@end

@implementation MonthsListViewController

@synthesize monthsArray;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        NSLog(@"Executing initWithNibName");
        
        NSMutableArray *monthNames = [[NSMutableArray alloc] initWithObjects:@"January", @"February", @"March", @"April",
                                       @"May", @"June", @"July", @"August", @"September", @"October", @"November", @"December",
                                       nil];
        
        int currentYear = 2012;
        Month *m;
        
        self.monthsArray = [[NSMutableArray alloc] initWithObjects:nil];
        
        while (currentYear >= 2007) {
            for (int i = 0; i < monthNames.count; i++) {
                m = [[Month alloc] initWithName:[monthNames objectAtIndex:i] AndYear:currentYear];
                [self.monthsArray addObject:m];
            }
            currentYear--;
        }
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.navigationItem setTitle:@"Select Month"];
}

- (void)viewDidUnload
{
    monthsTable = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.monthsArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [monthsTable dequeueReusableCellWithIdentifier:@"Cell"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    
    Month *m = [self.monthsArray objectAtIndex:[indexPath row]];
    
    [cell.textLabel setText:[m toString]];
    [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
    return cell;
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
