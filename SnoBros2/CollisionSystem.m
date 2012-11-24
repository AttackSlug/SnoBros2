//
//  CollisionSystem.m
//  SnoBros2
//
//  Created by Cjab on 11/20/12.
//  Copyright (c) 2012 Cjab. All rights reserved.
//

#import "CollisionSystem.h"
#import "EventManager.h"
#import "EntityManager.h"
#import "Entity.h"
#import "Event.h"
#import "Transform.h"
#import "Collision.h"

@implementation CollisionSystem

- (id)initWithEventManager:(EventManager *)eventManager
             entityManager:(EntityManager *)entityManager {
  self = [super init];
  if (self) {
    eventManager_  = eventManager;
    entityManager_ = entityManager;
  }
  return self;
}



- (void)update {
  NSArray *entities = [entityManager_ findAllWithComponent:@"Collision"];

  for (Entity *e in entities) {
    [self checkCollisionsFor:e];
  }
}



- (void)checkCollisionsFor:(Entity *)entity {
  NSArray *otherEntities =[entityManager_ entitiesNear:entity];

  for (Entity *other in otherEntities) {
    if ([self didEntity:entity collideWith:other]) {
      Event *event     = [[Event alloc] initWithType:@"collidedWith"
                                              target:other.uuid
                                             payload:other];
      [eventManager_ addEvent:event];
    }
  }
}



- (bool)didEntity:(Entity *)entity collideWith:(Entity *)other {
  Collision *myCollision    = [entity getComponentByString:@"Collision"];
  Collision *otherCollision = [other getComponentByString:@"Collision"];
  Transform *myTransform    = [entity getComponentByString:@"Transform"];
  Transform *otherTransform = [other getComponentByString:@"Transform"];
  
  if (entity == other || !otherCollision) { return false; }

  float radius      = myCollision.radius;
  float otherRadius = otherCollision.radius;
  float distance    = GLKVector2Distance(myTransform.position,
                                         otherTransform.position);

  if (distance < (radius + otherRadius)) {
    return true;
  }

  return false;
}

@end