//
//  Location+HumanityTest.m
//  HumanityTest
//
//  Created by Dejan Bekic on 7/5/15.
//  Copyright (c) 2015 Dejan Bekic. All rights reserved.
//

#import "Location+HumanityTest.h"

NSString *const kLocationState = @"state";
NSString *const kLocationNeighborhood = @"neighborhood";
NSString *const kLocationCrossStreet = @"crossStreet";
NSString *const kLocationLat = @"lat";
NSString *const kLocationAddress = @"address";
NSString *const kLocationFormattedAddress = @"formattedAddress";
NSString *const kLocationCity = @"city";
NSString *const kLocationPostalCode = @"postalCode";
NSString *const kLocationCc = @"cc";
NSString *const kLocationLng = @"lng";
NSString *const kLocationDistance = @"distance";
NSString *const kLocationCountry = @"country";

@implementation Location (HumanityTest)

+ (Location *) objectWithId:(NSString *)id managedObjectContext:(NSManagedObjectContext *) managedObjectContext {
    //No id for this object on the api. Each time location venue is updated, old contact will be deleted, and venue will be connected with the new one
    return nil;
}

+ (Location *) objectWithInfo:(NSDictionary *)info managedObjectContext:(NSManagedObjectContext *)managedObjectContext {
    return [[self alloc] initWithDictionary:info
                       managedObjectContext:managedObjectContext];
}

- (Location *) initWithDictionary:(NSDictionary *) json managedObjectContext:(NSManagedObjectContext *)managedObjectContext {
    Location *object = nil;
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Location" inManagedObjectContext:managedObjectContext];
    object = [[Location alloc] initWithEntity:entity insertIntoManagedObjectContext:managedObjectContext];
    [object updateWithInfo:json];
    [managedObjectContext save:nil];
    return object;
}

- (void) updateWithInfo:(NSDictionary *)info {
    self.state = [self objectOrNilForKey:kLocationState fromDictionary:info];
    self.neighborhood = [self objectOrNilForKey:kLocationNeighborhood fromDictionary:info];
    self.crossStreet = [self objectOrNilForKey:kLocationCrossStreet fromDictionary:info];
    self.lat = [NSNumber numberWithDouble:[[self objectOrNilForKey:kLocationLat fromDictionary:info] doubleValue]];
    self.lng = [NSNumber numberWithDouble:[[self objectOrNilForKey:kLocationLng fromDictionary:info] doubleValue]];
    self.address = [self objectOrNilForKey:kLocationAddress fromDictionary:info];
    self.city = [self objectOrNilForKey:kLocationCity fromDictionary:info];
    self.postalCode = [self objectOrNilForKey:kLocationPostalCode fromDictionary:info];
    self.cc = [self objectOrNilForKey:kLocationCc fromDictionary:info];
    self.country = [self objectOrNilForKey:kLocationCountry fromDictionary:info];
}

@end
