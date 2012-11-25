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

- (id)initWithEntity:(Entity *)entity {
  return [super initWithEntity:entity];
}



- (id)initWithEntity:(Entity *)entity dictionary:(NSDictionary *)data {
  return [self initWithEntity:entity];
}



- (void)update {
  Transform *transform = [entity_ getComponentByString:@"Transform"];
  Physics   *physics   = [entity_ getComponentByString:@"Physics"];
  GLKVector2 position = transform.position;

  if (position.x < 0 || position.x > 480) {
    physics.velocity =
      GLKVector2Make(-physics.velocity.x,
                      physics.velocity.y);
  }

  if (transform.position.y < 0 || transform.position.y > 320) {
    physics.velocity =  GLKVector2Make( physics.velocity.x,
                                       -physics.velocity.y);
  }
}

@end