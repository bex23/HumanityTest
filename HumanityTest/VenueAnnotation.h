//
//  VenueAnnotation.h
//  HumanityTest
//
//  Created by Dejan Bekic on 7/6/15.
//  Copyright (c) 2015 Dejan Bekic. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@class Venue;

@interface VenueAnnotation : NSObject <MKAnnotation>

@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;
@property (nonatomic, strong, readonly) Venue *venue;

- (id)initWithVenue:(Venue *)venue;

@end