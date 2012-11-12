//
//  Camera.m
//  SnoBros2
//
//  Created by Tanoy Sinha on 11/12/12.
//  Copyright (c) 2012 Cjab. All rights reserved.
//

#import "Camera.h"

@implementation Camera

@synthesize position = position_;
@synthesize target = target_;



- (id)init {
  self = [super init];
  if (self) {
    position_ = GLKVector2Make(0, 0);
    target_ = GLKVector2Make(0, 0);
    maxspeed_ = 10;
  }
  return self;
}



-(void)moveCameraToTarget:(GLKVector2)target {
  target_ = GLKVector2Subtract(target, GLKVector2Make(240, 180));
}



-(void)update {
  if (GLKVector2Distance(target_, position_) < 1) {
    target_ = position_;
    return;
  }
  GLKVector2 unitHeading = GLKVector2Normalize(GLKVector2Subtract(target_, position_));
  position_ = GLKVector2Add(position_, GLKVector2MultiplyScalar(unitHeading, maxspeed_));
}



@end
