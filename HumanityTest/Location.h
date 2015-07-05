//
//  Location.h
//  HumanityTest
//
//  Created by Dejan Bekic on 7/5/15.
//  Copyright (c) 2015 Dejan Bekic. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Venue;

@interface Location : NSManagedObject

@property (nonatomic, retain) NSString * state;
@property (nonatomic, retain) NSString * neighborhood;
@property (nonatomic, retain) NSString * crossStreet;
@property (nonatomic, retain) NSNumber * lat;
@property (nonatomic, retain) NSNumber * lng;
@property (nonatomic, retain) NSString * address;
@property (nonatomic, retain) NSString * city;
@property (nonatomic, retain) NSString * postalCode;
@property (nonatomic, retain) NSString * cc;
@property (nonatomic, retain) NSString * country;
@property (nonatomic, retain) Venue *venue;

@end
