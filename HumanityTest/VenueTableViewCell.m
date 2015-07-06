//
//  VenueTableViewCell.m
//  HumanityTest
//
//  Created by Dejan Bekic on 7/6/15.
//  Copyright (c) 2015 Dejan Bekic. All rights reserved.
//

#import "VenueTableViewCell.h"
#import "Venue.h"
#import "Location.h"
#import "Tip.h"

@interface VenueTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
@property (weak, nonatomic) IBOutlet UILabel *checkinsCount;
@end

@implementation VenueTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void) setUpWithVenue:(Venue *)venue {
    [self.nameLabel setText:venue.name];
    [self.addressLabel setText:venue.location.address];
    [self.checkinsCount setText:[NSString stringWithFormat:@"%lu", [venue.checkinsCount integerValue]]];
    
    if ([venue.tips count]) {
        //For need of this test task just get the first tip
        Tip *tip = [[venue.tips allObjects] firstObject];
        NSString *formatedTip = [NSString stringWithFormat:@"%@ by %@", tip.text, tip.tipBy];
        [self.tipLabel setText:formatedTip];
    } else {
        [self.tipLabel setText:@"No tips"];
    }
}

@end
