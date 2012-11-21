//
//  CollisionSystem.h
//  SnoBros2
//
//  Created by Cjab on 11/20/12.
//  Copyright (c) 2012 Cjab. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Entity;
@class EventManager;
@class EntityManager;

@interface CollisionSystem : NSObject {
  EventManager  *eventManager_;
  EntityManager *entityManager_;
}

- (id)initWithEventManager:(EventManager *)eventManager
             entityManager:(EntityManager *)entityManager;

- (void)update;
- (void)checkCollisionsFor:(Entity *)entity;
- (bool)didEntity:(Entity *)entity collideWith:(Entity *)other;

@end