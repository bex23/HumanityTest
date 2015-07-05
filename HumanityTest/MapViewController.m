//
//  MapViewController.m
//  HumanityTest
//
//  Created by Dejan Bekic on 7/4/15.
//  Copyright (c) 2015 Dejan Bekic. All rights reserved.
//

#import "MapViewController.h"
#import "AFNetworking.h"
#import <MapKit/MapKit.h>
#import "FoursquareVenueManager.h"
#import <CoreLocation/CoreLocation.h>
#import "LocationAccessViewController.h"

@interface MapViewController ()<LocationAccessDelegate>
@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    //check if app is authorized to use location services
    if (!([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedWhenInUse) &&
        !([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedAlways)) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1.0 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            LocationAccessViewController *lavc = [self.storyboard instantiateViewControllerWithIdentifier:@"LocationAccess"];
            [lavc setDelegate:self];
            [self presentViewController:lavc animated:YES completion:nil];
        });
    } else {
#warning  start updating location
    }
}

#pragma mark - location access delegate

- (void) didGrantAccessToLocation {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
