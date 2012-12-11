//
//  FPSMeter.h
//  SnoBros2
//
//  Created by Tanoy Sinha on 12/11/12.
//  Copyright (c) 2012 Attack Slug. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FPSMeter : UILabel {
  int   refreshCounter_;
  int   refreshRate_;
}

- (id)initWithFrame:(CGRect)frame;
- (id)initWithFrame:(CGRect)frame
        refreshRate:(int)refreshRate;

- (void)updateWithElaspedTime:(float)time;

@end
