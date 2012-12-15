//
//  CollisionResolutionSystem.m
//  SnoBros2
//
//  Created by Chad Jablonski on 12/15/12.
//  Copyright (c) 2012 Attack Slug. All rights reserved.
//

#import "CollisionResolutionSystem.h"

#import "EntityManager.h"
#import "Entity.h"
#import "Transform.h"
#import "Collision.h"
#import "Physics.h"


@implementation CollisionResolutionSystem
- (id)initWithEntityManager:(EntityManager *)entityManager {
  self = [super init];
  if (self) {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleCollidedWith:)
                                                 name:@"collidedWith"
                                               object:nil];
  }
  return self;
}



- (void)handleCollidedWith:(NSNotification *)notification {
  Entity *entity = [notification userInfo][@"entity"];

  if ([entity hasComponent:@"UnitCollider"] || [entity hasComponent:@"StandardCollider"]) {
    Entity *otherEntity  = [notification userInfo][@"otherEntity"];
    [self resolveCollisionBetween:entity and:otherEntity];
  }
}



- (void)resolveCollisionBetween:(Entity *)entity and:(Entity *)otherEntity {
  Transform *transform    = [entity getComponentByString:@"Transform"];
  Physics   *physics      = [entity getComponentByString:@"Physics"];
  GLKVector2 intersection = [self intersectionBetween:entity and:otherEntity];

  [transform translate:intersection];

  //TODO: Currently this is the only difference between colliders, we may be
  //      able to remove it altogether.
  if ([entity hasComponent:@"StandardCollider"]) {
    physics.velocity = GLKVector2MultiplyScalar(physics.velocity, -1.f);
  }
}



- (GLKVector2)intersectionBetween:(Entity *)entity and:(Entity *)otherEntity {
  Collision *myCollision    = [entity      getComponentByString:@"Collision"];
  Collision *otherCollision = [otherEntity getComponentByString:@"Collision"];
  Transform *myTransform    = [entity      getComponentByString:@"Transform"];
  Transform *otherTransform = [otherEntity getComponentByString:@"Transform"];

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