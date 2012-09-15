//
//  Month.h
//  Expense Tracking
//
//  Created by Tri Vuong on 9/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Month : NSObject

@property (nonatomic, retain) NSString *name;
@property (nonatomic) NSInteger year;

- (id)initWithName:(NSString *)name AndYear:(NSInteger)year;
- (NSString *)toString;

@end
