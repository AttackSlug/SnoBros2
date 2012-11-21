//
//  Camera.m
//  SnoBros2
//
//  Created by Tanoy Sinha on 11/12/12.
//  Copyright (c) 2012 Cjab. All rights reserved.
//

#import "Camera.h"
#import "Event.h"
#import "EventManager.h"

@implementation Camera

@synthesize position = position_;
@synthesize target   = target_;
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



- (void)panCameraWithHeading:(GLKVector2)heading {
  position_ = GLKVector2Add(position_,
                            GLKVector2MultiplyScalar(heading, maxspeed_));
}



- (void)panCameraToTarget:(GLKVector2)target {
  target_ = GLKVector2Subtract(target, GLKVector2Make(240, 160));
}



- (void)updateWithEventManager:(EventManager *)eventManager {
  if (GLKVector2Distance(position_, target_) > 10) {
    GLKVector2 heading = GLKVector2Normalize(GLKVector2Subtract(target_, position_));
    NSValue   *payload = [NSValue value:&heading withObjCType:@encode(GLKVector2)];

    Event *event = [[Event alloc] initWithType:@"panCameraWithHeading"
                                        target:@"camera"
                                       payload:payload];
    [eventManager addEvent:event];
  }
}



- (void)receiveEvent:(Event *)event {
  if ([event.type isEqualToString:@"panCameraToTarget"]) {

    GLKVector2 target;
    [event.payload getValue:&target];
    [self panCameraToTarget:target];

  } else if ([event.type isEqualToString:@"panCameraWithHeading"]) {

    GLKVector2 heading;
    [event.payload getValue:&heading];
    [self panCameraWithHeading:heading];

  }
}

@end