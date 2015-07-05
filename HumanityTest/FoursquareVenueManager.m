//
//  LocationManager.m
//  HumanityTest
//
//  Created by Dejan Bekic on 7/5/15.
//  Copyright (c) 2015 Dejan Bekic. All rights reserved.
//

#import "FoursquareVenueManager.h"
#import <CoreLocation/CoreLocation.h>

NSString * const kLocationManagerDidChangeAuthorizationStatus = @"kLocationManagerDidChangeAuthorizationStatus";

@interface FoursquareVenueManager()<CLLocationManagerDelegate>
@property (strong, nonatomic) CLLocationManager *locationManager;
@end

@implementation FoursquareVenueManager

#pragma mark - lazy instantiation

- (CLLocationManager *)locationManager {
    if (!_locationManager) {
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        _locationManager.delegate = self;
    } return _locationManager;
}

#pragma mark - core location manager delegate

- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation {
}

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error {
    NSLog(@"Location manager did fail with error %@", error);
    [self.locationManager stopUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    [[NSNotificationCenter defaultCenter] postNotificationName:kLocationManagerDidChangeAuthorizationStatus
                                                        object:@(status)];
}

#pragma mark - singleton management

static FoursquareVenueManager *sharedManager;

/*  Initialize the singleton instance if needed and return
    Another way to create singleton is using dispatch_once
    However I preffer the method bellow without using GCD   */
+ (FoursquareVenueManager *)sharedManager {
    @synchronized(self)
    {
        if (!sharedManager){
            sharedManager = [[FoursquareVenueManager alloc] init];
        }
        return sharedManager;
    }
}

+ (id)alloc {
    @synchronized(self)
    {
        NSAssert(sharedManager == nil, @"Attempted to allocate a second instance of a singleton.");
        sharedManager = [super alloc];
        return sharedManager;
    }
}

+ (id)copy {
    @synchronized(self)
    {
        NSAssert(sharedManager == nil, @"Attempted to copy the singleton.");
        return sharedManager;
    }
}

@end