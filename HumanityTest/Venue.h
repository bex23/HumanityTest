//
//  Venue.h
//  HumanityTest
//
//  Created by Dejan Bekic on 7/5/15.
//  Copyright (c) 2015 Dejan Bekic. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Contact, Location, Tip;

@interface Venue : NSManagedObject

@property (nonatomic, retain) NSString * id;
@property (nonatomic, retain) NSNumber * checkinsCount;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) Contact *contact;
@property (nonatomic, retain) Location *location;
@property (nonatomic, retain) NSSet *tips;
@end

@interface Venue (CoreDataGeneratedAccessors)

- (void)addTipsObject:(Tip *)value;
- (void)removeTipsObject:(Tip *)value;
- (void)addTips:(NSSet *)values;
- (void)removeTips:(NSSet *)values;

@end
