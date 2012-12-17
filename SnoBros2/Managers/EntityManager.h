//
//  EntityManager.h
//  SnoBros2
//
//  Created by Chad Jablonski on 11/17/12.
//  Copyright (c) 2012 Attack Slug. All rights reserved.
//

#import <GLKit/GLKit.h>
#import <Foundation/Foundation.h>

@class Entity;
@class BoundingBox;
@class Quadtree;

@interface EntityManager : NSObject {
  NSMutableDictionary *entities_;
  NSMutableDictionary *entitiesByComponent_;
  NSMutableDictionary *entityTypes_;
  Quadtree            *quadtree_;
}

- (id)init;

- (void)add:(Entity *)entity;
- (void)remove:(Entity *)entity;
- (void)update;

- (Entity *)buildEntity:(NSString *)type;
- (void)loadEntityTypesFromFile:(NSString *)filename;

- (BOOL)isEntitySelected;

- (NSArray *)sortByLayer:(NSArray *)entities;
- (NSArray *)findByTeamName:(NSString *)name;
- (NSArray *)findAllWithComponent:(NSString *)component;
- (Entity  *)findEntityDisplayedAtPosition:(GLKVector2)target;
- (NSArray *)findAllWithinBoundingBox:(BoundingBox *)boundingBox;
- (NSArray *)findAllNear:(BoundingBox *)boundingBox;
- (NSArray *)findCollisionGroups;
- (NSArray *)findAllSelected;

@end