//
//  EntityManager.h
//  SnoBros2
//
//  Created by Cjab on 11/17/12.
//  Copyright (c) 2012 Cjab. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Entity;
@class Quadtree;

@interface EntityManager : NSObject {
  NSMutableDictionary *entities_;
  NSMutableArray      *toBeDeleted_;
  NSMutableArray      *toBeCreated_;
  NSMutableDictionary *entityTypes_;
  Quadtree            *quadtree_;
}

- (id)init;

- (void)add:(Entity *)entity;
- (void)remove:(Entity *)entity;

- (void)loadEntityTypesFromFile:(NSString *)filename;
- (Entity *)buildEntity:(NSString *)type;
- (Entity *)buildAndAddEntity:(NSString *)type;

- (void)queueForDeletion:(Entity *)entity;
- (void)queueForCreation:(Entity *)entity;

- (NSArray *)allEntities;
- (NSArray *)allSortedByLayer;
- (NSArray *)entitiesNear:(Entity *)entity;
- (Entity *)findById:(NSString *)entityId;
- (NSArray *)findByTag:(NSString *)tag;
- (NSArray *)findAllWithComponent:(NSString *)component;
- (NSArray *)findAllSelected;

- (BOOL)isEntitySelected;
- (void)selectById:(NSString *)entityId;
- (void)deselectAll;

- (void)processQueue;
- (void)update;

@end