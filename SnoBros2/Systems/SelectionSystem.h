//
//  SelectionSystem.h
//  SnoBros2
//
//  Created by Chad Jablonski on 11/27/12.
//  Copyright (c) 2012 Attack Slug. All rights reserved.
//

#import <GLKit/GLKit.h>
#import <Foundation/Foundation.h>

#import "GameSystem.h"

@class EntityManager;
@class Entity;
@class BoundingBox;

@interface SelectionSystem : NSObject <GameSystem> {
  EntityManager *entityManager_;
  Entity        *leader_;
}

- (id)initWithEntityManager:(EntityManager *)entityManager;

- (NSArray *)findAllSelected;
- (BOOL)isEntitySelected;
- (void)selectEntity:(Entity *)entity;
- (void)selectEntityDisplayedAtPosition:(NSNotification *)notification;
- (void)selectAllWithinBoundingBox:(NSNotification *)notification;
- (void)deselectAll;

@end