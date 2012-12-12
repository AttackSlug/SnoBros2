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

@interface EntityManager : NSObject {
  NSMutableDictionary *entities_;
  NSMutableArray      *toBeDeleted_;
  NSMutableArray      *toBeCreated_;
  NSMutableDictionary *entityTypes_;
}

- (id)init;

- (void)add:(Entity *)entity;
- (void)remove:(Entity *)entity;
- (void)queueForDeletion:(Entity *)entity;
- (void)queueForCreation:(Entity *)entity;
- (void)processQueue;
- (void)update;

- (Entity *)buildEntity:(NSString *)type;
- (Entity *)buildAndAddEntity:(NSString *)type;
- (void)loadEntityTypesFromFile:(NSString *)filename;

- (NSArray *)allEntities;
- (NSArray *)sortByLayer:(NSArray *)entities;
- (Entity  *)findById:(NSString *)entityId;
- (NSArray *)findByTeamName:(NSString *)name;
- (NSArray *)findAllWithComponent:(NSString *)component;
- (Entity  *)findEntityDisplayedAtPosition:(GLKVector2)target;
- (NSArray *)findAllWithinBoundingBox:(BoundingBox *)boundingBox;

@end