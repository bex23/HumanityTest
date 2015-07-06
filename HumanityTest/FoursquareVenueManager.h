//
//  LocationManager.h
//  HumanityTest
//
//  Created by Dejan Bekic on 7/5/15.
//  Copyright (c) 2015 Dejan Bekic. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CLLocationManager;
@class CLLocation;

extern NSString * const kLocationManagerDidChangeAuthorizationStatus;

@protocol FoursquareVenueManagerDelegate <NSObject>

- (void) didUpdateToLocation:(CLLocation *)location;
- (void) didUpdateVenues;

@end

//This class collects information about venues based on user location and passes it to the controllers
@interface FoursquareVenueManager : NSObject

+ (FoursquareVenueManager *) sharedManager;
@property (strong, nonatomic, readonly) CLLocationManager *locationManager;
@property (weak, nonatomic) id<FoursquareVenueManagerDelegate> delegate;

- (NSArray *) allVenues;

@end
