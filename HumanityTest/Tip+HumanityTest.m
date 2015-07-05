//
//  Tip+HumanityTest.m
//  HumanityTest
//
//  Created by Dejan Bekic on 7/5/15.
//  Copyright (c) 2015 Dejan Bekic. All rights reserved.
//

#import "Tip+HumanityTest.h"

NSString *const kTipId = @"id";
NSString *const kTipText = @"text";
NSString *const kTipCreatedAt = @"createdAt";
NSString *const kTipUser = @"user";

@implementation Tip (HumanityTest)

+ (Tip *) objectWithId:(NSString *)id managedObjectContext:(NSManagedObjectContext *)managedObjectContext {
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Tip"];
    [request setPredicate:[NSPredicate predicateWithFormat:@"id = %@", id]];
    NSArray *results = [managedObjectContext executeFetchRequest:request error:nil];
    return (Tip *)[results uniqueObject];
}

+ (Tip *) objectWithInfo:(NSDictionary *)info managedObjectContext:(NSManagedObjectContext *)managedObjectContext {
    return [[self alloc] initWithDictionary:info
                       managedObjectContext:managedObjectContext];
}

- (Tip *) initWithDictionary:(NSDictionary *) json managedObjectContext:(NSManagedObjectContext *)managedObjectContext {
    Tip *object = nil;
    NSString *id = [json objectForKey:kTipId];
    if (id) {
        object = [Tip objectWithId:id managedObjectContext:managedObjectContext];
    }
    if (!object) {
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"Tip" inManagedObjectContext:managedObjectContext];
        object = [[Tip alloc] initWithEntity:entity insertIntoManagedObjectContext:managedObjectContext];
    }
    [object updateWithInfo:json];
    [managedObjectContext save:nil];
    return object;
}

- (void) updateWithInfo:(NSDictionary *)info {
    self.id = [self objectOrNilForKey:kTipId fromDictionary:info];
    self.text = [self objectOrNilForKey:kTipText fromDictionary:info];
    self.createdAt = [NSNumber numberWithInteger:[[self objectOrNilForKey:kTipCreatedAt fromDictionary:info] integerValue]];
    if ([info objectForKey:kTipUser]) {
        NSString *firstName = [self objectOrNilForKey:@"firstName" fromDictionary:info[kTipUser]];
        NSString *lastName = [self objectOrNilForKey:@"lastName" fromDictionary:info[kTipUser]];
        if (firstName.length && lastName.length) {
            self.tipBy = [NSString stringWithFormat:@"%@ %@", firstName, lastName];
        } else  {
            self.tipBy = nil;
        }
    }
}

@end
