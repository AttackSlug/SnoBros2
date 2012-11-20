//
//  Sphere.m
//  SnoBros2
//
//  Created by Cjab on 11/12/12.
//  Copyright (c) 2012 Cjab. All rights reserved.
//

#import "Sphere.h"
#import "Entity.h"
#import "Transform.h"
#import "Physics.h"

@implementation Sphere

- (void)update {
  GLKVector2 position = entity_.transform.position;

  if (position.x < 0 || position.x > 480) {
    entity_.physics.velocity =
      GLKVector2Make(-entity_.physics.velocity.x,
                      entity_.physics.velocity.y);
  }

  if (transform_.position.y < 0 || transform_.position.y > 320) {
    entity_.physics.velocity =
      GLKVector2Make( entity_.physics.velocity.x,
                     -entity_.physics.velocity.y);
  }
}

- (void)collidedWith:(NSValue *)value {
  NSLog(@"Handling collision!");
}

@end