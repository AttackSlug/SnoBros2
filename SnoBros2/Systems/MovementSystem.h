//
//  MovementSystem.h
//  SnoBros2
//
//  Created by Chad Jablonski on 12/7/12.
//  Copyright (c) 2012 Attack Slug. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GLKit/GLKit.h>

#import "GameSystem.h"

@class EntityManager;
@class Entity;

#define DISTANCE_MARGIN 4.f

@interface MovementSystem : NSObject <GameSystem> {
  EntityManager *entityManager_;
}

- (id)initWithEntityManager:(EntityManager *)entityManager;

- (void)update;
- (void)handleWalkTo:(NSNotification *)notification;
- (void)entity:(Entity *)entity walkToTarget:(GLKVector2)target;

@end