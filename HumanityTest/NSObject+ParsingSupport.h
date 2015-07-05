//
//  NSObject+ParsingSupport.h
//  HumanityTest
//
//  Created by Dejan Bekic on 7/5/15.
//  Copyright (c) 2015 Dejan Bekic. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (ParsingSupport)

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end
