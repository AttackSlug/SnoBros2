//
//  CollisionSystem.h
//  SnoBros2
//
//  Created by Chad Jablonski on 11/20/12.
//  Copyright (c) 2012 Attack Slug. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "GameSystem.h"

@class Entity;
@class EntityManager;

@interface CollisionSystem : NSObject <GameSystem> {
  EntityManager *entityManager_;
}

- (id)initWithEntityManager:(EntityManager *)entityManager;

- (void)update;
- (BOOL)didEntity:(Entity *)entity collideWith:(Entity *)other;

@end