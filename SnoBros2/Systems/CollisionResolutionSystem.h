//
//  CollisionResolutionSystem.h
//  SnoBros2
//
//  Created by Chad Jablonski on 12/15/12.
//  Copyright (c) 2012 Attack Slug. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GLKit/GLKit.h>

@class EntityManager;
@class Entity;

@interface CollisionResolutionSystem : NSObject

- (id)initWithEntityManager:(EntityManager *)entityManager;

- (void)handleCollidedWith:(NSNotification *)notification;

- (void)resolveCollisionBetween:(Entity *)entity and:(Entity *)otherEntity;
- (GLKVector2)intersectionBetween:(Entity *)entity and:(Entity *)otherEntity;

@end