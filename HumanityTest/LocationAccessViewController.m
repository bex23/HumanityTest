//
//  LocationAccessViewController.m
//  HumanityTest
//
//  Created by Dejan Bekic on 7/5/15.
//  Copyright (c) 2015 Dejan Bekic. All rights reserved.
//

#import "LocationAccessViewController.h"
#import "FoursquareVenueManager.h"
#import <CoreLocation/CoreLocation.h>

@interface LocationAccessViewController ()
@property (weak, nonatomic) IBOutlet UIView *accessView;
@property (weak, nonatomic) IBOutlet UIView *openSettingsView;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (weak, nonatomic) IBOutlet UILabel *headerLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UIButton *actionButton;
@end

@implementation LocationAccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.locationManager = [[FoursquareVenueManager sharedManager] locationManager];
    //observe location manager authorization status
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didChangeAuthorizationStatus:)
                                                 name:kLocationManagerDidChangeAuthorizationStatus
                                               object:nil];
    if ([CLLocationManager authorizationStatus] != kCLAuthorizationStatusNotDetermined) {
        [self updateTextForNonAuthorized];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onAllow:(UIButton *)sender {
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined) {
        [UIView animateWithDuration:0.3 animations:^{
            [self.accessView setAlpha:0.0];
        } completion:^(BOOL finished){
            [self.locationManager requestWhenInUseAuthorization];
        }];
    } else {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
    }
}

- (void)updateTextForNonAuthorized{
    [self.headerLabel setText:@"Location access not granted"];
    [self.descriptionLabel setText:@"You need to allow this app to access your location. You can enable this through settings."];
    [self.actionButton setTitle:@"Open Settings" forState:UIControlStateNormal];
}

#pragma mark - location manager authorization observer

- (void) didChangeAuthorizationStatus:(NSNotification *)notification {
    CLAuthorizationStatus status = [notification.object intValue];
    if (status == kCLAuthorizationStatusAuthorizedWhenInUse) {
        [[NSNotificationCenter defaultCenter] removeObserver:self
                                                        name:kLocationManagerDidChangeAuthorizationStatus
                                                      object:nil];
        [self.delegate didGrantAccessToLocation];
    } else if (status != kCLAuthorizationStatusNotDetermined) {
        //Update text
        [self updateTextForNonAuthorized];
        [UIView animateWithDuration:0.3 animations:^{
            //Display label
            [self.accessView setAlpha:1.0];
        }];
    }
}

@end
