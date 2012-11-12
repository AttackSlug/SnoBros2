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
@synthesize viewport = viewport_;



- (id)init {
  self = [super init];
  if (self) {
    position_ = GLKVector2Make(0, 0);
    target_ = GLKVector2Make(0, 0);
    viewport_ = GLKVector2Make(480, 320);
    maxspeed_ = 10;
    
  }
  return self;
}



-(void)panCameraWithHeading:(GLKVector2)heading {
  position_ = GLKVector2Add(position_, GLKVector2MultiplyScalar(heading, maxspeed_));
}



@end
