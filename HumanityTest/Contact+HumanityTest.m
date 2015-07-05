//
//  Contact+HumanityTest.m
//  HumanityTest
//
//  Created by Dejan Bekic on 7/5/15.
//  Copyright (c) 2015 Dejan Bekic. All rights reserved.
//

#import "Contact+HumanityTest.h"

NSString *const kContactPhone = @"phone";
NSString *const kContactTwitter = @"twitter";
NSString *const kContactFacebook = @"facebook";
NSString *const kContactFormattedPhone = @"formattedPhone";
NSString *const kContactFacebookUsername = @"facebookUsername";
NSString *const kContactFacebookName = @"facebookName";

@implementation Contact (HumanityTest)

+ (Contact *) objectWithId:(NSString *)id managedObjectContext:(NSManagedObjectContext *) managedObjectContext {
    //No id for this object on the api. Each time location venue is updated, old contact will be deleted, and venue will be connected with the new one
    return nil;
}

+ (Contact *) objectWithInfo:(NSDictionary *)info managedObjectContext:(NSManagedObjectContext *)managedObjectContext {
    return [[self alloc] initWithDictionary:info
                       managedObjectContext:managedObjectContext];
}

- (Contact *) initWithDictionary:(NSDictionary *) json managedObjectContext:(NSManagedObjectContext *)managedObjectContext {
    Contact *object = nil;
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Contact" inManagedObjectContext:managedObjectContext];
    object = [[Contact alloc] initWithEntity:entity insertIntoManagedObjectContext:managedObjectContext];
    [object updateWithInfo:json];
    [managedObjectContext save:nil];
    return object;
}

- (void) updateWithInfo:(NSDictionary *)info {
    self.phone = [self objectOrNilForKey:kContactPhone fromDictionary:info];
    self.twitter = [self objectOrNilForKey:kContactTwitter fromDictionary:info];
    self.formattedPhone = [self objectOrNilForKey:kContactFormattedPhone fromDictionary:info];
    self.facebook = [self objectOrNilForKey:kContactFacebook fromDictionary:info];
    self.facebookName = [self objectOrNilForKey:kContactFacebookName fromDictionary:info];
    self.facebookUsername = [self objectOrNilForKey:kContactFacebookUsername fromDictionary:info];
}

@end
