//
//  LocationManager.m
//  HumanityTest
//
//  Created by Dejan Bekic on 7/5/15.
//  Copyright (c) 2015 Dejan Bekic. All rights reserved.
//

#import "FoursquareVenueManager.h"
#import <CoreLocation/CoreLocation.h>
#import "AppDelegate.h"
#import "APIManager.h"
#import "Venue+HumanityTest.h"

NSString * const kLocationManagerDidChangeAuthorizationStatus = @"kLocationManagerDidChangeAuthorizationStatus";
const double kRadius = 500.0;

@interface FoursquareVenueManager()<CLLocationManagerDelegate>
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) APIManager *apiManager;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) CLLocation *lastFetchedLocation;
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

- (APIManager *) apiManager {
    if (!_apiManager) {
        _apiManager = [[APIManager alloc] init];
    } return _apiManager;
}

- (NSManagedObjectContext *)managedObjectContext {
    if (!_managedObjectContext) {
        //Although it might not be a good practice to make managedObjectContext live through the app, for needs of this test assignment it will only be used here.
        _managedObjectContext = [(AppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext];
    } return _managedObjectContext;
}

#pragma mark - core location manager delegate

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    if ([self.delegate respondsToSelector:@selector(didUpdateToLocation:)]) {
        [self.delegate didUpdateToLocation:[locations lastObject]];
    }
    if (!self.lastFetchedLocation || ([self.lastFetchedLocation distanceFromLocation:[locations lastObject]] > kRadius/2)) {
        [self getVenuesForLocation:[locations lastObject]];
    }
}

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error {
    NSLog(@"Location manager did fail with error %@", error);
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    [[NSNotificationCenter defaultCenter] postNotificationName:kLocationManagerDidChangeAuthorizationStatus
                                                        object:@(status)];
}

#pragma mark - get venues

- (void)getVenuesForLocation:(CLLocation *)location {
    self.lastFetchedLocation = location;
    [self.apiManager getBarsAtLocation:location
                              atRadius:@(kRadius)
                               success:^(NSURLSessionDataTask *task, id responseObject) {
                                   NSMutableArray *items = [NSMutableArray new];
                                   NSArray *groups = responseObject[@"response"][@"groups"];
                                   //get items from all groups
                                   for (NSDictionary *group in groups) {
                                       for (NSDictionary *item in group[@"items"]) {
                                           [items addObject:item];
                                       }
                                   }
                                   //save to core data
                                   for (NSDictionary *item in items) {
                                       [Venue objectWithInfo:item managedObjectContext:self.managedObjectContext];
                                   }
                                   //let the view now about the update
                                   if ([self.delegate respondsToSelector:@selector(didUpdateVenues)]) {
                                       [self.delegate didUpdateVenues];
                                   }
                               }
                               failure:^(NSURLSessionDataTask *task, NSError *error) {
                                   NSLog(@"%@", error);
                                   self.lastFetchedLocation = nil;
                               }];
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