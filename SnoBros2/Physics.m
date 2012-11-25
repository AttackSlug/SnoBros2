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
#import "Collision.h"

@implementation Physics

@synthesize velocity = velocity_;

- (id)initWithEntity:(Entity *)entity {
  self = [super initWithEntity:entity];
  if (self) {
    NSString *collisionEvent = [entity_.uuid
                                stringByAppendingString:@"|collidedWith"];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(collidedWith:)
                                                 name:collisionEvent
                                               object:nil];
  }
  return self;
}



- (void)collidedWith:(NSNotification *)notification {
  Entity *other = [notification userInfo][@"otherEntity"];
  [self resolveCollisionWith:other];
}



- (id)initWithEntity:(Entity *)entity dictionary:(NSDictionary *)data {
  self = [self initWithEntity:entity];
  if (self) {
    NSDictionary *v = [data valueForKey:@"velocity"];
    velocity_ = GLKVector2Make([[v valueForKey:@"x"] floatValue],
                               [[v valueForKey:@"y"] floatValue]);
  }
  return self;
}



- (void)update {
  Transform *transform = [entity_ getComponentByString:@"Transform"];
  [transform translate:velocity_];
}



- (void)resolveCollisionWith:(Entity *)otherEntity {
  Transform *transform = [entity_ getComponentByString:@"Transform"];
  GLKVector2 intersection = [self intersectionWith:otherEntity];
  [transform translate:intersection];

  velocity_ = GLKVector2Make(-velocity_.x, -velocity_.y);
}



- (GLKVector2)intersectionWith:(Entity *)other {
  Collision *myCollision    = [entity_ getComponentByString:@"Collision"];
  Collision *otherCollision = [other getComponentByString:@"Collision"];
  Transform *myTransform    = [entity_ getComponentByString:@"Transform"];
  Transform *otherTransform = [other getComponentByString:@"Transform"];
  float radius       = myCollision.radius;
  float otherRadius  = otherCollision.radius;
  float distance     = GLKVector2Distance(myTransform.position,
                                          otherTransform.position);
  float overlap      = 1 - (distance / (radius + otherRadius));
  GLKVector2 centers = GLKVector2Subtract(myTransform.position,
                                          otherTransform.position);

  return GLKVector2MultiplyScalar(centers, overlap);
}

@end