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

#import "Quadtree.h"
#import "BoundingBox.h"
#import "ASFloat.h"

@implementation CollisionSystem

- (id)initWithEntityManager:(EntityManager *)entityManager {
  self = [super init];
  if (self) {
    entityManager_ = entityManager;

    GLKVector2 boundsOrigin = GLKVector2Make(512.f, 512.f);
    CGSize     boundsSize   = CGSizeMake(1024.f, 1024.f);
    BoundingBox *bounds     = [[BoundingBox alloc] initWithOrigin:boundsOrigin
                                                             size:boundsSize];
    quadtree_      = [[Quadtree alloc] initWithBounds:bounds];
  }
  return self;
}



- (void)update {
  NSArray *entities = [entityManager_ findAllWithComponent:@"Collision"];

  [quadtree_ clear];

  for (Entity *entity in entities) {
    Collision *collision = [entity getComponentByString:@"Collision"];
    [quadtree_ addObject:entity withBoundingBox:collision.boundingBox];
  }

  for (Entity *entity in entities) {
    [self checkCollisionsFor:entity];
  }
}



- (void)checkCollisionsFor:(Entity *)entity {
  Collision *collision   = [entity getComponentByString:@"Collision"];

  NSArray *otherEntities = [quadtree_ retrieveObjectsNear:collision.boundingBox];

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

  if ([ASFloat is:distance lessThanOrEqualTo:centersDistance]) {
    return true;
  }

  return false;
}

@end