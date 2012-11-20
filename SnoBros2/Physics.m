//
//  Physics.m
//  Component
//
//  Created by Cjab on 11/1/12.
//  Copyright (c) 2012 Cjab. All rights reserved.
//

#import "Physics.h"
#import "Transform.h"
#import "Entity.h"
#import "Transform.h"

@implementation Physics

@synthesize velocity = velocity_;

- (id)initWithEntity:(Entity *)entity transform:(Transform *)transform {
  self = [super initWithEntity:entity];
  if (self) {
    transform_ = transform;
  }
  return self;
}



- (void)update {
  [transform_ translate:velocity_];
}



- (void)resolveCollisionWith:(Entity *)otherEntity
                intersection:(GLKVector2)intersection {
  [transform_ translate:intersection];
  velocity_ = GLKVector2Make(-velocity_.x, -velocity_.y);

  otherEntity.physics.velocity =
    GLKVector2MultiplyScalar(otherEntity.physics.velocity, -1);
}



@end