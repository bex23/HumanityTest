//
//  NSArray+ParsingSupport.m
//  HumanityTest
//
//  Created by Dejan Bekic on 7/5/15.
//  Copyright (c) 2015 Dejan Bekic. All rights reserved.
//

#import "NSArray+ParsingSupport.h"

@implementation NSArray (ParsingSupport)

- (id)uniqueObject {
    if (self.count <= 0) {
        return nil;
    }
    if (self.count > 1) {
        NSLog(@"uniqueObject returned %lu results", (unsigned long)[self count]);
        abort();
    }
    return [self lastObject];
}

@end
