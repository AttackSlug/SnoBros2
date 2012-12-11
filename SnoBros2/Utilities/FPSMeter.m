//
//  FPSMeter.m
//  SnoBros2
//
//  Created by Tanoy Sinha on 12/11/12.
//  Copyright (c) 2012 Attack Slug. All rights reserved.
//

#import "FPSMeter.h"

@implementation FPSMeter

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}



- (id)initWithFrame:(CGRect)frame
        refreshRate:(int)refreshRate {
  self = [self initWithFrame:frame];
  if (self) {
    refreshCounter_       = 0;
    refreshRate_          = refreshRate;
    self.textColor        = [UIColor whiteColor];
    self.backgroundColor  = [UIColor clearColor];
  }
  return self;
}



- (void)updateWithElaspedTime:(float)time {
  refreshCounter_++;
  if (refreshCounter_ > refreshRate_) {
    self.text = [NSString stringWithFormat:@"%d", (int)(1.f/time)];
    refreshCounter_ = 0;
  }
}

@end
