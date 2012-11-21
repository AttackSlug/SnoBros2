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
#import "Event.h"
#import "Collision.h"

@implementation Physics

@synthesize velocity = velocity_;

- (id)initWithEntity:(Entity *)entity {
  return [super initWithEntity:entity];
}



- (void)update {
  [entity_.transform translate:velocity_];
}



- (void)resolveCollisionWith:(Entity *)otherEntity {
  GLKVector2 intersection = [self intersectionWith:otherEntity];
  [entity_.transform translate:intersection];

  velocity_ = GLKVector2Make(-velocity_.x, -velocity_.y);
}



- (GLKVector2)intersectionWith:(Entity *)other {
  float radius       = entity_.collision.radius;
  float otherRadius  = other.collision.radius;
  float distance     = GLKVector2Distance(entity_.transform.position,
                                          other.transform.position);
  float overlap      = 1 - (distance / (radius + otherRadius));
  GLKVector2 centers = GLKVector2Subtract(entity_.transform.position,
                                          other.transform.position);

  return GLKVector2MultiplyScalar(centers, overlap);
}



- (void)receiveEvent:(Event *)event {
  if ([event.type isEqualToString:@"collidedWith"]) {

    Entity *other = event.payload;
    [self resolveCollisionWith:other];

  }
}

@end