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

@interface MapViewController ()

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

@end
