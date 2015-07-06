//
//  APIManager.m
//  HumanityTest
//
//  Created by Dejan Bekic on 7/5/15.
//  Copyright (c) 2015 Dejan Bekic. All rights reserved.
//

#import "APIManager.h"
#import <CoreLocation/CoreLocation.h>

NSString *const BASE_URL = @"https://api.foursquare.com/v2";
NSString *const FOURSQUARE_CLIENT_ID = @"15ECEJQWIF3AGERRT2H1JFELPWOQR3JDSCJJNPY3LAYV0SQN";
NSString *const FOURSQUARE_CLIENT_SECRET = @"AVT1B3Z33CEQ5Q5K2UPIRKVPB0BSY4S2TSRPVX1DYPJ2EGQR";
NSString *const FOURSQUARE_API_VERSION = @"20150705";
NSString *const CATEGORY_ID = @"4bf58dd8d48988d116941735";

@implementation APIManager

- (instancetype)init
{
    self = [super initWithBaseURL:[NSURL URLWithString:BASE_URL]];
    if (self) {
        self.responseSerializer = [AFJSONResponseSerializer serializer];
        self.requestSerializer = [AFHTTPRequestSerializer serializer];
        self.requestSerializer.timeoutInterval = 10.0;
    }
    return self;
}

- (void) getBarsAtLocation:(CLLocation *)location
                  atRadius:(NSNumber *)radius
                   success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                   failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure {
    if ([[AFNetworkReachabilityManager sharedManager] networkReachabilityStatus] != AFNetworkReachabilityStatusNotReachable) {
        NSDictionary *parameters = @{@"client_id" : FOURSQUARE_CLIENT_ID,
                                     @"client_secret" : FOURSQUARE_CLIENT_SECRET,
                                     @"v" : FOURSQUARE_API_VERSION,
                                     @"categoryId" : CATEGORY_ID, //get only bars
                                     @"radius" : radius,
                                     @"ll" : [NSString stringWithFormat:@"%f, %f", location.coordinate.latitude, location.coordinate.longitude]};
        [self GET:@"venues/explore" parameters:parameters
          success:^(NSURLSessionDataTask *task, id responseObject) {
              success(task, responseObject);
          }
          failure:^(NSURLSessionDataTask *task, NSError *error) {
              failure(task, error);
          }];
    } else  {
        failure(nil, nil);
    }
}

- (void) startMonitoringReachability {
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
}

@end
