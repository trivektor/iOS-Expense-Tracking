//
//  Month.m
//  Expense Tracking
//
//  Created by Tri Vuong on 9/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Month.h"

@implementation Month

@synthesize name, year;

- (id)initWithName:(NSString *)_name AndYear:(NSInteger)_year
{
    self.name = _name;
    self.year = _year;
    
    return self;
}

- (NSString *)toString
{
    NSString *s = [[NSString alloc] init];
    s = [s stringByAppendingString:self.name];
    s = [s stringByAppendingString:@" "];
    s = [s stringByAppendingString:[NSString stringWithFormat:@"%i", self.year]];
    
    return s;
}

@end
