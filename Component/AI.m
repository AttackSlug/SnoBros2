//
//  AI.m
//  Component
//
//  Created by Cjab on 11/5/12.
//  Copyright (c) 2012 Cjab. All rights reserved.
//

#import "Entity.h"
#import "AI.h"

@implementation AI


- (id)initWithEntity:(Entity *)entity
           transform:(Transform *)transform
             physics:(Physics *)physics {
  self = [super initWithEntity:entity];
  if (self) {
    transform_ = transform;
    physics_   = physics;
  }
  return self;
}



- (void)update {
  if (GLKVector2Distance(transform_.position, target_) > 5) {
    physics_.velocity = GLKVector2MultiplyScalar(direction_, 5);
  } else {
    physics_.velocity = GLKVector2Make(0.f, 0.f);
  }
}



- (void)walkTo:(GLKVector2)target {
  GLKVector2 position = transform_.position;
  target_    = target;
  direction_ = GLKVector2Normalize(GLKVector2Subtract(target_, position));
}


@end