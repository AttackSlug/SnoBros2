//
//  CollisionSystem.h
//  SnoBros2
//
//  Created by Chad Jablonski on 11/20/12.
//  Copyright (c) 2012 Attack Slug. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Entity;
@class EntityManager;
@class Quadtree;

@interface CollisionSystem : NSObject {
  Quadtree      *quadtree_;
  EntityManager *entityManager_;
}

- (id)initWithEntityManager:(EntityManager *)entityManager;

- (void)handleEntityCreated:(NSNotification *)notification;
- (void)handleEntityDestroyed:(NSNotification *)notification;

- (void)update;
- (BOOL)didEntity:(Entity *)entity collideWith:(Entity *)other;

@end