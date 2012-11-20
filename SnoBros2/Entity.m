//
//  Entity.m
//  Component
//
//  Created by Cjab on 11/1/12.
//  Copyright (c) 2012 Cjab. All rights reserved.
//

#import "Entity.h"
#import "Transform.h"
#import "Renderer.h"
#import "Physics.h"
#import "Input.h"
#import "Behavior.h"
#import "Camera.h"
#import "Collision.h"
#import "Sprite.h"

@implementation Entity

@synthesize transform   = transform_;
@synthesize renderer    = renderer_;
@synthesize physics     = physics_;
@synthesize sprite      = sprite_;
@synthesize behavior    = behavior_;
@synthesize collision   = collision_;
@synthesize selectable  = selectable_;
@synthesize tag         = tag_;
@synthesize uuid        = uuid_;

- (id)init {
  return [self initWithTag:@"untagged"];
}



- (id)initWithTag:(NSString *)tag {
  self = [super init];
  if (self) {
    tag_ = tag;
    CFUUIDRef uuid = CFUUIDCreate(NULL);
    uuid_ = (__bridge_transfer NSString *)CFUUIDCreateString(NULL, uuid);
    CFRelease(uuid);
  }
  return self;
}



- (void)update {
  [behavior_  update];
  [collision_ update];
  [physics_   update];
  [renderer_  update];
}



- (void)renderWithCamera:(Camera*)camera interpolationRatio:(double)ratio {
  [renderer_ renderWithCamera:camera interpolationRatio:ratio];
}

@end