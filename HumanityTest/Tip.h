//
//  Tip.h
//  HumanityTest
//
//  Created by Dejan Bekic on 7/5/15.
//  Copyright (c) 2015 Dejan Bekic. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Venue;

@interface Tip : NSManagedObject

@property (nonatomic, retain) NSString * id;
@property (nonatomic, retain) NSString * text;
@property (nonatomic, retain) NSNumber * createdAt;
@property (nonatomic, retain) NSString * tipBy;
@property (nonatomic, retain) Venue *venue;

@end
