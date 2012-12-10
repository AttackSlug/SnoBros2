//
//  EnemyBehaviorSystem.m
//  SnoBros2
//
//  Created by Cjab on 12/10/12.
//  Copyright (c) 2012 Attack Slug. All rights reserved.
//

#import "EnemyBehaviorSystem.h"

#import "EntityManager.h"
#import "Entity.h"
#import "Attack.h"
#import "Transform.h"
#import "Collision.h"

#import "Quadtree.h"

@implementation EnemyBehaviorSystem

- (id)initWithEntityManager:(EntityManager *)entityManager {
  self = [super init];
  if (self) {
    entityManager_ = entityManager;
    quadtree_      = [[Quadtree alloc] initWithBounds:CGRectMake(0.f, 0.f,
                                                                1024.f, 1024.f)];
  }
  return self;
}


- (void)update {
  NSArray *players = [entityManager_ findByTeamName:@"Team Edward"];
  NSArray *enemies = [entityManager_ findByTeamName:@"Team Jacob"];
  float maxRange   = 0.f;
  NSArray *inRange;

  [quadtree_ clear];

  for (Entity *enemy in enemies) {
    Attack *attack = [enemy getComponentByString:@"Attack"];
    Collision *collision = [enemy getComponentByString:@"Collision"];

    if (attack.range > maxRange) {
      maxRange = attack.range;
    }

    [quadtree_ addObject:enemy withBoundingBox:collision.boundingBox];
  }

  for (Entity *player in players) {
    Transform *transform = [player getComponentByString:@"Transform"];
    CGRect rangeBounds   = CGRectMake(transform.position.x, transform.position.y,
                                      maxRange, maxRange);

    inRange = [quadtree_ retrieveObjectsNear:rangeBounds];

    for (Entity *enemy in inRange) {
      Transform *enemyTransform = [enemy getComponentByString:@"Transform"];
      Attack    *enemyAttack    = [enemy getComponentByString:@"Attack"];
      float distance = GLKVector2Distance(transform.position,
                                          enemyTransform.position);
      if (distance <= enemyAttack.range) {
        [enemyAttack fireAt:transform.position];
      }
    }
  }
}

@end