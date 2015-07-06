//
//  MapViewController.m
//  HumanityTest
//
//  Created by Dejan Bekic on 7/4/15.
//  Copyright (c) 2015 Dejan Bekic. All rights reserved.
//

#import "MapViewController.h"
#import <MapKit/MapKit.h>
#import "FoursquareVenueManager.h"
#import <CoreLocation/CoreLocation.h>
#import "LocationAccessViewController.h"
#import "VenueAnnotation.h"
#import "Venue+HumanityTest.h"
#import "Contact+HumanityTest.h"
#import "VenuesListTableViewController.h"
#import "AFNetworkReachabilityManager.h"

@interface MapViewController ()<LocationAccessDelegate, FoursquareVenueManagerDelegate, MKMapViewDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UILabel *offlineLabel;
@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[FoursquareVenueManager sharedManager] setDelegate:self];
    [self.mapView setDelegate:self];
    [self setAnnotations];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onNetworkChange:) name:AFNetworkingReachabilityDidChangeNotification object:nil];
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
    [self zoomToLocation:location];
}

- (void) didUpdateVenues {
    //inform list view controller about the update. Other soultion would be to make VenueListViewController subclass of NSfetchedresultscontroller and handle core data updates automatically.
    if (self.presentedViewController != nil) {
        UINavigationController *navi = (UINavigationController *) self.presentedViewController;
        VenuesListTableViewController *vltvc = navi.viewControllers[0];
        [vltvc promptRefresh];
    }
    //udapte map with possible new entries
    [self setAnnotations];
}

#pragma mark - map view data source

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
    if (annotation == mapView.userLocation){
        return nil; //default to blue dot
    } else  if ([annotation isKindOfClass:[VenueAnnotation class]]) {
            MKAnnotationView *annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:@"VenueAnnotation"];
            if (annotationView == nil) {
                annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"VenueAnnotation"];
                annotationView.image = [UIImage imageNamed:@"Pin"];
                annotationView.enabled = YES;
                annotationView.canShowCallout = YES;
                UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
                [button setImage:[UIImage imageNamed:@"Phone"] forState:UIControlStateNormal];
                annotationView.rightCalloutAccessoryView = button;
            } else {
                annotationView.annotation = annotation;
            }
            
            return annotationView;
    } return nil;
}

- (void) zoomToLocation:(CLLocation *)location {
    MKCoordinateRegion region;
    MKCoordinateSpan span;
    span.latitudeDelta = 0.04;
    span.longitudeDelta = 0.04;
    CLLocationCoordinate2D newLocation;
    newLocation.latitude = location.coordinate.latitude;
    newLocation.longitude = location.coordinate.longitude;
    region.span = span;
    region.center = newLocation;
    [self.mapView setRegion:region animated:YES];
}

- (void) setAnnotations {
    [self.mapView removeAnnotations:self.mapView.annotations];
    for (Venue *venue in [[FoursquareVenueManager sharedManager] allVenues]) {
        [self.mapView addAnnotation:[[VenueAnnotation alloc] initWithVenue:venue]];
    }
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
#if (TARGET_IPHONE_SIMULATOR)
    [[[UIAlertView alloc] initWithTitle:@"Sorry"
                                message:@"Calls through simulator are not supported. Please run this app on actual device to use this feature."
                               delegate:nil
                      cancelButtonTitle:@"OK"
                      otherButtonTitles:nil] show];
#else
    VenueAnnotation *annotation = (VenueAnnotation *)view.annotation;
    NSString *number = [NSString stringWithFormat:@"tel:%@", annotation.venue.contact.phone];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:number]];
#endif
}


#pragma mark - button actions

- (IBAction)onNavigationArrow:(UIBarButtonItem *)sender {
    [self zoomToLocation:self.mapView.userLocation.location];
}

- (IBAction)onList:(UIBarButtonItem *)sender {
    UINavigationController *navigation = [self.storyboard instantiateViewControllerWithIdentifier:@"List"];
    [self presentViewController:navigation animated:YES completion:nil];
}

#pragma mark - reachability change

//display network change
- (void) onNetworkChange:(NSNotification *)notification {
    if (notification.userInfo[AFNetworkingReachabilityNotificationStatusItem]) {
        if ([notification.userInfo[AFNetworkingReachabilityNotificationStatusItem] integerValue] == AFNetworkReachabilityStatusNotReachable
        || [notification.userInfo[AFNetworkingReachabilityNotificationStatusItem] integerValue] == AFNetworkReachabilityStatusUnknown) {
            [UIView animateWithDuration:0.3 animations:^{
                [self.offlineLabel setAlpha:1.0];
            }];
        } else {
            [UIView animateWithDuration:0.3 animations:^{
                [self.offlineLabel setAlpha:0.0];
            }];
        }
    }
}

@end