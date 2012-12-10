//
//  Camera.m
//  SnoBros2
//
//  Created by Tanoy Sinha on 11/12/12.
//  Copyright (c) 2012 Attack Slug. All rights reserved.
//

#import "Camera.h"

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
    maxspeed_ = 4;

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(panCameraToTarget:)
                                                 name:@"panCameraToTarget"
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(panCameraWithHeading:)
                                                 name:@"panCameraWithHeading"
                                               object:nil];
  }
  return self;
}



- (void)update {
  if (GLKVector2Distance(position_, target_) > 10) {
    GLKVector2 heading = GLKVector2Normalize(GLKVector2Subtract(target_, position_));
    NSValue   *payload = [NSValue value:&heading withObjCType:@encode(GLKVector2)];
    NSDictionary *data = @{@"heading": payload};

    [[NSNotificationCenter defaultCenter] postNotificationName:@"panCameraWithHeading"
                                                        object:self
                                                      userInfo:data];
  }
}



- (void)panCameraWithHeading:(NSNotification *)notification {
  GLKVector2 heading;
  [[notification userInfo][@"heading"] getValue:&heading];

  position_ = GLKVector2Add(position_,
                            GLKVector2MultiplyScalar(heading, maxspeed_));
}



- (void)panCameraToTarget:(NSNotification *)notification {
  GLKVector2 target;
  [[notification userInfo][@"target"] getValue:&target];

  target_ = GLKVector2Subtract(target, GLKVector2Make(240, 160));
}

@end