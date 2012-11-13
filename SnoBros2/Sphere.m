//
//  Sphere.m
//  SnoBros2
//
//  Created by Cjab on 11/12/12.
//  Copyright (c) 2012 Cjab. All rights reserved.
//

#import "Sphere.h"

@implementation Sphere


- (void)update {
  if (transform_.position.x < 0 || transform_.position.x > 480) {
    physics_.velocity =
      GLKVector2Make(-physics_.velocity.x, physics_.velocity.y);
  }

  if (transform_.position.y < 0 || transform_.position.y > 320) {
    physics_.velocity =
      GLKVector2Make(physics_.velocity.x, -physics_.velocity.y);
  }
}


@end