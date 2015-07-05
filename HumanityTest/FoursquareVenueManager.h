//
//  LocationManager.h
//  HumanityTest
//
//  Created by Dejan Bekic on 7/5/15.
//  Copyright (c) 2015 Dejan Bekic. All rights reserved.
//

@class CLLocationManager;

#import <Foundation/Foundation.h>

//This class collects information about venues based on user location and passes it to the controllers
@interface FoursquareVenueManager : NSObject

+ (FoursquareVenueManager *) sharedManager;

@end
