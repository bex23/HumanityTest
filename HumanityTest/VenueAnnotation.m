//
//  VenueAnnotation.m
//  HumanityTest
//
//  Created by Dejan Bekic on 7/6/15.
//  Copyright (c) 2015 Dejan Bekic. All rights reserved.
//

#import "VenueAnnotation.h"
#import "Venue+HumanityTest.h"
#import "Location+HumanityTest.h"
#import "Contact+HumanityTest.h"
#import <CoreLocation/CoreLocation.h>

@interface VenueAnnotation()
@property (strong , nonatomic) Venue *venue;
@end

@implementation VenueAnnotation

- (id)initWithVenue:(Venue *)venue {
    self = [super init];
    if (self) {
        CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake([venue.location.lat doubleValue],
                                                                       [venue.location.lng doubleValue]);
        self.coordinate = coordinate;
        self.title = venue.name;
        self.subtitle = venue.location.address;
        self.venue = venue;
    }
    return self;
}

@end


