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

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleEntityCreated:)
                                                 name:@"entityCreated"
                                               object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleEntityDestroyed:)
                                                 name:@"entityDestroyed"
                                               object:nil];
  }
  return self;
}



- (void)update {
  NSArray *entities = [entityManager_ findAllWithComponent:@"Collision"];

  for (Entity *entity in entities) {
    Transform *transform = [entity getComponentByString:@"Transform"];
    if ([transform hasMoved]) {
      Collision *collision = [entity getComponentByString:@"Collision"];
      [quadtree_ removeObject:entity];
      [quadtree_ addObject:entity withBoundingBox:collision.boundingBox];
    }
  }

  NSArray *collisionGroups = [quadtree_ retrieveCollisionGroups];
  for (NSArray *group in collisionGroups) {
    for (int i = 0; i < group.count; i++) {
      Entity *entity = group[i];
      for (int j = i + 1; j < group.count; j++) {
        Entity *other  = group[j];

        if ([self didEntity:entity collideWith:other]) {

          NSString *name = [entity.uuid stringByAppendingString:@"|collidedWith"];
          NSDictionary *data = @{@"otherEntity": other};
          [[NSNotificationCenter defaultCenter] postNotificationName:name
                                                              object:self
                                                            userInfo:data];

          NSString *otherName = [other.uuid stringByAppendingString:@"|collidedWith"];
          NSDictionary *otherData = @{@"otherEntity": entity};
          [[NSNotificationCenter defaultCenter] postNotificationName:otherName
                                                              object:self
                                                            userInfo:otherData];
        }
      }
    }
  }
}



- (void)handleEntityCreated:(NSNotification *)notification {
  Entity    *entity    = [notification userInfo][@"entity"];
  Collision *collision = [entity getComponentByString:@"Collision"];
  [quadtree_ addObject:entity withBoundingBox:collision.boundingBox];
}



- (void)handleEntityDestroyed:(NSNotification *)notification {
  Entity *entity = [notification userInfo][@"entity"];
  [quadtree_ removeObject:entity];
}



- (bool)didEntity:(Entity *)entity collideWith:(Entity *)other {
  Transform *myTransform    = [entity getComponentByString:@"Transform"];
  Transform *otherTransform = [other  getComponentByString:@"Transform"];

  if (myTransform.hasMoved == FALSE && otherTransform.hasMoved == FALSE) {
    return FALSE;
  }

  Collision *myCollision    = [entity getComponentByString:@"Collision"];
  Collision *otherCollision = [other  getComponentByString:@"Collision"];

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
