//
//  VenueTableViewCell.h
//  HumanityTest
//
//  Created by Dejan Bekic on 7/6/15.
//  Copyright (c) 2015 Dejan Bekic. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Venue;

@interface VenueTableViewCell : UITableViewCell

- (void) setUpWithVenue:(Venue *)venue;

@end
