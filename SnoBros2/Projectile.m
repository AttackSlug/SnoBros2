//
//  Projectile.m
//  Component
//
//  Created by Cjab on 11/8/12.
//  Copyright (c) 2012 Cjab. All rights reserved.
//

#import "Projectile.h"

@implementation Projectile


- (void)walkTo:(GLKVector2)target {
  if (target.x < 240) { return; }
  GLKVector2 position = transform_.position;
  target_    = target;
  direction_ = GLKVector2Normalize(GLKVector2Subtract(target_, position));
}

- (void)update {
  if (GLKVector2Distance(transform_.position, target_) > 10) {
    physics_.velocity = GLKVector2MultiplyScalar(direction_, 10);
  } else {
    physics_.velocity = GLKVector2Make(0.f, 0.f);
  }
}


@end