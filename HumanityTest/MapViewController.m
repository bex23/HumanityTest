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

@interface MapViewController ()<LocationAccessDelegate, FoursquareVenueManagerDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    [[FoursquareVenueManager sharedManager] setDelegate:self];
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
        [[[FoursquareVenueManager sharedManager] locationManager] startUpdatingLocation];
        [self.mapView setShowsUserLocation:YES];
    }
}

#pragma mark - location access delegate

- (void) didGrantAccessToLocation {
    [self.mapView setShowsUserLocation:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - foursquare venue manager delegate

- (void) didUpdateToLocation:(CLLocation *)location {
    MKCoordinateRegion region;
    MKCoordinateSpan span;
    span.latitudeDelta = 0.003;
    span.longitudeDelta = 0.003;
    CLLocationCoordinate2D newLocation;
    newLocation.latitude = location.coordinate.latitude;
    newLocation.longitude = location.coordinate.longitude;
    region.span = span;
    region.center = newLocation;
    [self.mapView setRegion:region animated:YES];
}

- (void) didUpdateVenues {
    
}

@end
