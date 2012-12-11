//
//  SelectionSystem.h
//  SnoBros2
//
//  Created by Chad Jablonski on 11/27/12.
//  Copyright (c) 2012 Attack Slug. All rights reserved.
//

#import <GLKit/GLKit.h>
#import <Foundation/Foundation.h>

@class EntityManager;
@class Entity;
@class BoundingBox;

@interface SelectionSystem : NSObject {
  EntityManager *entityManager_;
  Entity        *leader_;
}

- (id)initWithEntityManager:(EntityManager *)entityManager;

- (NSArray *)findAllSelected;
- (BOOL)isEntitySelected;
- (void)selectById:(NSString *)entityId;
- (void)selectEntity:(Entity *)entity;
- (Entity *)selectEntityDisplayedAtPosition:(GLKVector2)target;
- (void)selectAllWithinBoundingBox:(BoundingBox *)boundingBox;
- (void)deselectAll;

@end