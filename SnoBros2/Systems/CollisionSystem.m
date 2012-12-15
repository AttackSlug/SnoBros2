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

#import "ASFloat.h"

@implementation CollisionSystem

- (id)initWithEntityManager:(EntityManager *)entityManager {
  self = [super init];
  if (self) {
    entityManager_ = entityManager;
  }
  return self;
}



- (void)update {
  NSArray *collisionGroups = [entityManager_ findCollisionGroups];

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



- (BOOL)didEntity:(Entity *)entity collideWith:(Entity *)other {
  Transform *myTransform    = [entity getComponentByString:@"Transform"];
  Transform *otherTransform = [other  getComponentByString:@"Transform"];

  if (myTransform.hasMoved == NO && otherTransform.hasMoved == NO) {
    return NO;
  }

  Collision *myCollision    = [entity getComponentByString:@"Collision"];
  Collision *otherCollision = [other  getComponentByString:@"Collision"];

  float radius          = myCollision.radius;
  float otherRadius     = otherCollision.radius;
  float centersDistance = radius + otherRadius;
  float distance        = GLKVector2Distance(myTransform.position,
                                             otherTransform.position);

  if (FLOAT_LESS_THAN_OR_EQUAL(distance, centersDistance)) {
    return YES;
  }

  return NO;
}

@end