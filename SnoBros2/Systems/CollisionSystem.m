//
//  CollisionSystem.m
//  SnoBros2
//
//  Created by Chad Jablonski on 11/20/12.
//  Copyright (c) 2012 Attack Slug. All rights reserved.
//

#import "CollisionSystem.h"
#import "EntityManager.h"
#import "Entity.h"
#import "Transform.h"
#import "Collision.h"

#import "Float.h"

@implementation CollisionSystem

- (id)initWithEntityManager:(EntityManager *)entityManager {
  self = [super init];
  if (self) {
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
      NSString *name = [entity.uuid stringByAppendingString:@"|collidedWith"];
      NSDictionary *data = @{@"otherEntity": other};
      [[NSNotificationCenter defaultCenter] postNotificationName:name
                                                          object:self
                                                        userInfo:data];
    }
  }
}



- (bool)didEntity:(Entity *)entity collideWith:(Entity *)other {
  Collision *myCollision    = [entity getComponentByString:@"Collision"];
  Collision *otherCollision = [other  getComponentByString:@"Collision"];
  Transform *myTransform    = [entity getComponentByString:@"Transform"];
  Transform *otherTransform = [other  getComponentByString:@"Transform"];
  
  if (entity == other || !otherCollision) { return false; }

  float radius          = myCollision.radius;
  float otherRadius     = otherCollision.radius;
  float centersDistance = radius + otherRadius;
  float distance        = GLKVector2Distance(myTransform.position,
                                             otherTransform.position);

  if ([Float is:distance lessThanOrEqualTo:centersDistance]) {
    return true;
  }

  return false;
}

@end