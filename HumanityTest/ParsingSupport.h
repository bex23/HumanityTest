//
//  ParsingSupport.h
//  HumanityTest
//
//  Created by Dejan Bekic on 7/5/15.
//  Copyright (c) 2015 Dejan Bekic. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+ParsingSupport.h"
#import "NSArray+ParsingSupport.h"

@class NSManagedObjectContext;

@protocol ParsingSupport <NSObject>
+ (instancetype) objectWithId:(NSString *)id managedObjectContext:(NSManagedObjectContext *)managedObjectContext;
+ (instancetype) objectWithInfo:(NSDictionary *)info managedObjectContext:(NSManagedObjectContext *)managedObjectContext;
- (instancetype) initWithDictionary:(NSDictionary *) json managedObjectContext:(NSManagedObjectContext *)managedObjectContext;
@end