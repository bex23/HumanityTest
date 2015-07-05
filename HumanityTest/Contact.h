//
//  Contact.h
//  HumanityTest
//
//  Created by Dejan Bekic on 7/5/15.
//  Copyright (c) 2015 Dejan Bekic. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Venue;

@interface Contact : NSManagedObject

@property (nonatomic, retain) NSString * phone;
@property (nonatomic, retain) NSString * formattedPhone;
@property (nonatomic, retain) NSString * facebookName;
@property (nonatomic, retain) NSString * facebookUsername;
@property (nonatomic, retain) NSString * twitter;
@property (nonatomic, retain) NSString * facebook;
@property (nonatomic, retain) Venue *venue;

@end
