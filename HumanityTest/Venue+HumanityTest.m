//
//  Venue+HumanityTest.m
//  HumanityTest
//
//  Created by Dejan Bekic on 7/5/15.
//  Copyright (c) 2015 Dejan Bekic. All rights reserved.
//

#import "Venue+HumanityTest.h"
#import "Location+HumanityTest.h"
#import "Contact+HumanityTest.h"
#import "Tip+HumanityTest.h"

NSString *const kTopLevelVenue = @"venue";
NSString *const kTopLevelTips = @"tips";

NSString *const kVenueId = @"id";
NSString *const kVenueName = @"name";
NSString *const kVenueStats = @"stats";
NSString *const kVenueContact = @"contact";
NSString *const kVenueLocation = @"location";

NSString *const kStatsCheckinsCount = @"checkinsCount";

@implementation Venue (HumanityTest)

+ (Venue *) objectWithId:(NSString *)id managedObjectContext:(NSManagedObjectContext *) managedObjectContext {
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Venue"];
    [request setPredicate:[NSPredicate predicateWithFormat:@"id = %@", id]];
    NSArray *results = [managedObjectContext executeFetchRequest:request error:nil];
    return (Venue *)[results uniqueObject];
}

+ (Venue *) objectWithInfo:(NSDictionary *)info managedObjectContext:(NSManagedObjectContext *)managedObjectContext {
    return [[self alloc] initWithDictionary:info
                       managedObjectContext:managedObjectContext];
}

- (Venue *) initWithDictionary:(NSDictionary *) json managedObjectContext:(NSManagedObjectContext *)managedObjectContext {
    Venue *object = nil;
    NSString *id = [[json objectForKey:kTopLevelVenue] objectForKey:kVenueId];
    if (id) {
        object = [Venue objectWithId:id managedObjectContext:managedObjectContext];
    }
    if (!object) {
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"Venue" inManagedObjectContext:managedObjectContext];
        object = [[Venue alloc] initWithEntity:entity insertIntoManagedObjectContext:managedObjectContext];
    } else {
        //delete contact and location
        [managedObjectContext deleteObject:object.location];
        [managedObjectContext deleteObject:object.contact];
    }
    [object updateWithInfo:json inManagedObjectContext:managedObjectContext];
    [managedObjectContext save:nil];
    return object;
}

- (void) updateWithInfo:(NSDictionary *)info inManagedObjectContext:(NSManagedObjectContext *)managedObjectContext {
    self.id = [self objectOrNilForKey:kVenueId fromDictionary:info[kTopLevelVenue]];
    self.name = [self objectOrNilForKey:kVenueName fromDictionary:info[kTopLevelVenue]];
    self.checkinsCount = [NSNumber numberWithInteger:[[self objectOrNilForKey:kStatsCheckinsCount   fromDictionary:info[kTopLevelVenue][kVenueStats]] integerValue]];
    
    //add location
    if ([self objectOrNilForKey:kVenueLocation fromDictionary:info[kTopLevelVenue]]) {
        self.location = [Location objectWithInfo:info[kTopLevelVenue][kVenueLocation] managedObjectContext:managedObjectContext];
    } else {
        self.location = nil;
    }
    
    //add contact
    if ([self objectOrNilForKey:kVenueContact fromDictionary:info[kTopLevelVenue]]) {
        self.contact = [Contact objectWithInfo:info[kTopLevelVenue][kVenueContact] managedObjectContext:managedObjectContext];
    } else {
        self.contact = nil;
    }
    
    //add tips
    for (NSDictionary *tipRaw in info[kTopLevelTips]) {
        [self addTipsObject:[Tip objectWithInfo:tipRaw
                           managedObjectContext:managedObjectContext]];
    }
}

#pragma mark - fetch

+ (NSArray *) allVenuesInManagedObjectContext:(NSManagedObjectContext *)managedObjectContext {
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Venue"];
    NSSortDescriptor *descriptor = [NSSortDescriptor sortDescriptorWithKey:@"checkinsCount"
                                                                 ascending:NO];
    [request setSortDescriptors:@[descriptor]];
    NSArray *results = [managedObjectContext executeFetchRequest:request error:nil];
    return results;
}

@end
