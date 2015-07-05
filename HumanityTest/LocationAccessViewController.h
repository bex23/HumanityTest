//
//  LocationAccessViewController.h
//  HumanityTest
//
//  Created by Dejan Bekic on 7/5/15.
//  Copyright (c) 2015 Dejan Bekic. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LocationAccessDelegate <NSObject>

- (void) didGrantAccessToLocation;

@end

@interface LocationAccessViewController : UIViewController

@property (weak, nonatomic) id<LocationAccessDelegate> delegate;

@end