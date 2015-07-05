//
//  APIManager.h
//  HumanityTest
//
//  Created by Dejan Bekic on 7/5/15.
//  Copyright (c) 2015 Dejan Bekic. All rights reserved.
//

#import "AFHTTPSessionManager.h"

@class CLLocation;

@interface APIManager : AFHTTPSessionManager

- (instancetype)init;
- (void) getBarsAtLocation:(CLLocation *)location
                  atRadius:(NSNumber *)radius;

@end
