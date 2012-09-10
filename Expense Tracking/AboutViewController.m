//
//  AboutViewController.m
//  Expense Tracking
//
//  Created by Tri Vuong on 9/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AboutViewController.h"

@interface AboutViewController ()

@end

@implementation AboutViewController

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
    [self.navigationItem setTitle:@"About This App"];
    //[self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"gray_sand.png"]]];
    [self.view setBackgroundColor:[UIColor whiteColor]];
}

- (void)viewDidUnload
{
    bioTextView = nil;
    twitterButton = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)visitTwitter:(id)sender
{
    NSURL *twitter = [[NSURL alloc] initWithString:@"twitter://user?screen_name=trivektor"];
    //NSURLRequest *req = [[NSURLRequest alloc] initWithURL:twitter];
    [[UIApplication sharedApplication] openURL:twitter];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
