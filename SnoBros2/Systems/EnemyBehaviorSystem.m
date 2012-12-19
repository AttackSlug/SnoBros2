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

#import "BoundingBox.h"
#import "ASFloat.h"

@implementation EnemyBehaviorSystem

- (id)initWithEntityManager:(EntityManager *)entityManager {
  self = [super init];
  if (self) {
    entityManager_ = entityManager;
  }
  return self;
}


- (void)update {
  NSArray *players = [entityManager_ findByTeamName:@"Team Edward"];
  NSArray *enemies = [entityManager_ findByTeamName:@"Team Jacob"];

  for (Entity *player in players) {
    Transform   *transform   = [player getComponentByString:@"Transform"];

    for (Entity *enemy in enemies) {
      Transform *enemyTransform = [enemy getComponentByString:@"Transform"];
      Attack    *enemyAttack    = [enemy getComponentByString:@"Attack"];
      float distance = GLKVector2Distance(transform.position,
                                          enemyTransform.position);
      if (FLOAT_LESS_THAN_OR_EQUAL(distance, enemyAttack.range)) {
        [enemyAttack fireAt:transform.position];
      }
    }
  }
}



- (void)activate {
  
}



- (void)deactivate {
  
}

@end