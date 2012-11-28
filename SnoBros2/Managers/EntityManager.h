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
- (NSArray *)findByTeamName:(NSString *)name;
- (NSArray *)findAllWithinRectangle:(CGRect)rectangle;
- (Entity *)findEntityDisplayedAtPosition:(GLKVector2)target;

- (void)processQueue;
- (void)update;

@end