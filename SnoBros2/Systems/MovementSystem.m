//
//  MovementSystem.m
//  SnoBros2
//
//  Created by Chad Jablonski on 12/7/12.
//  Copyright (c) 2012 Attack Slug. All rights reserved.
//

#import "MovementSystem.h"

#import "ASFloat.h"

#import "EntityManager.h"
#import "Entity.h"
#import "Physics.h"
#import "Transform.h"
#import "Collision.h"
#import "Movement.h"

@implementation MovementSystem

- (id)initWithEntityManager:(EntityManager *)entityManager {
  self = [super init];
  if (self) {
    entityManager_ = entityManager;
  }
  return self;
}



- (void)update {
  NSArray *entities = [entityManager_ findAllWithComponent:@"Movement"];

  for (Entity *entity in entities) {
    Transform *transform = [entity getComponentByString:@"Transform"];
    Physics   *physics   = [entity getComponentByString:@"Physics"];
    Movement  *movement  = [entity getComponentByString:@"Movement"];

    float distance = GLKVector2Distance(transform.position, movement.target);

    if (FLOAT_LESS_THAN(distance, DISTANCE_MARGIN)) {

      physics.velocity = GLKVector2Make(0.f, 0.f);
      movement.target  = transform.position;

      NSDictionary *arrivedData = @{@"entity": entity};
      [[NSNotificationCenter defaultCenter] postNotificationName:@"arrivedAtTarget"
                                                          object:self
                                                        userInfo:arrivedData];

    } else if ([physics isMovingAwayFrom:movement.target]) {

      [self entity:entity walkToTarget:movement.target];

    }
  }
}



- (void)handleWalkTo:(NSNotification *)notification {
  GLKVector2  target;
  Entity     *entity = [notification userInfo][@"entity"];

  [[notification userInfo][@"target"] getValue:&target];

  [self entity:entity walkToTarget:target];
}



- (void)entity:(Entity *)entity walkToTarget:(GLKVector2)target {
  Transform *transform = [entity getComponentByString:@"Transform"];
  Physics   *physics   = [entity getComponentByString:@"Physics"];
  Movement  *movement  = [entity getComponentByString:@"Movement"];

  movement.target =  target;
  GLKVector2 path = GLKVector2Subtract(target, transform.position);
  GLKVector2 direction;

  if (GLKVector2Length(path) == 0) {
    direction = GLKVector2Make(0.f, 0.f);
  } else {
    direction = GLKVector2Normalize(path);
  }

  physics.velocity = GLKVector2MultiplyScalar(direction, movement.speed);
}



- (void)activate {
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(handleWalkTo:)
                                               name:@"walkTo"
                                             object:nil];
}



- (void)deactivate {
  [[NSNotificationCenter defaultCenter] removeObserver:self
                                                  name:@"walkTo"
                                                object:nil];
}

@end