//
//  PathfindingSystem.h
//  SnoBros2
//
//  Created by Chad Jablonski on 12/3/12.
//  Copyright (c) 2012 Attack Slug. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GLKit/GLKit.h>

#import "GameSystem.h"

@class MapGrid;
@class EntityManager;
@class Entity;

@interface PathfindingSystem : NSObject <GameSystem> {
  MapGrid       *map_;
  EntityManager *entityManager_;
}

- (id)initWithEntityManager:(EntityManager *)entityManager;

- (void)handleFindPath:(NSNotification *)notification;
- (void)handleArrivedAtTarget:(NSNotification *)notification;

- (NSArray *)findPathFor:(Entity *)entity to:(GLKVector2)target;
- (void)arrivedAtTarget:(Entity *)entity;

@end