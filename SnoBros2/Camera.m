//
//  Camera.m
//  SnoBros2
//
//  Created by Tanoy Sinha on 11/12/12.
//  Copyright (c) 2012 Cjab. All rights reserved.
//

#import "Camera.h"
#import "Game.h"
#import "Event.h"

@implementation Camera

@synthesize position = position_;
@synthesize target = target_;
@synthesize viewport = viewport_;

- (id)init {
  self = [super init];
  if (self) {
    position_ = GLKVector2Make(0, 0);
    target_ = GLKVector2Make(-240, -160);
    viewport_ = GLKVector2Make(480, 320);
    maxspeed_ = 10;
  }
  return self;
}



- (void)panCameraWithHeading:(NSValue *)message {
  GLKVector2 heading;
  [message getValue:&heading];
  position_ = GLKVector2Add(position_, GLKVector2MultiplyScalar(heading, maxspeed_));
}



- (void)panCameraToTarget:(NSValue *)message {
  GLKVector2 target;
  [message getValue:&target];
  target_ = GLKVector2Subtract(target, GLKVector2Make(240, 160));
}



- (void)updateWithQueue:(Game *)queue {
  if (GLKVector2Distance(position_, target_) > 10) {
    GLKVector2 heading = GLKVector2Normalize(GLKVector2Subtract(target_, position_));
    Event *e = [[Event alloc] initWithID:@"c"
                                selector:@selector(panCameraWithHeading:)
                                 payload:[NSValue value:&heading withObjCType:@encode(GLKVector2)]];
    [queue addEvent:e];
  }
}

@end
