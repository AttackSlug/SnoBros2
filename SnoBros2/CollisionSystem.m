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
  NSArray *entities = [entityManager_ findAllWithComponent:@"collision"];

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
  if (entity == other || !other.collision) { return false; }

  float radius      = entity.collision.radius;
  float otherRadius = other.collision.radius;
  float distance    = GLKVector2Distance(entity.transform.position,
                                          other.transform.position);

  if (distance < (radius + otherRadius)) {
    return true;
  }

  return false;
}

@end