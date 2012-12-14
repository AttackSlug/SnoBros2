//
//  EntityManager.m
//  SnoBros2
//
//  Created by Chad Jablonski on 11/17/12.
//  Copyright (c) 2012 Attack Slug. All rights reserved.
//

#import "EntityManager.h"

#import "Entity.h"
#import "Selectable.h"
#import "Health.h"
#import "Team.h"
#import "SceneGraph.h"
#import "Transform.h"
#import "Collision.h"
#import "JSONLoader.h"

@implementation EntityManager

- (id)init {
  self = [super init];
  if (self) {
    entities_             = [[NSMutableDictionary alloc] init];
    entityTypes_          = [[NSMutableDictionary alloc] init];
    entitiesByComponent_  = [[NSMutableDictionary alloc] init];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(createEntity:)
                                                 name:@"createEntity"
                                               object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(destroyEntity:)
                                                 name:@"destroyEntity"
                                               object:nil];
  }
  return self;
}



- (void)add:(Entity *)entity {
  [entities_ setValue:entity forKey:entity.uuid];
  for (id key in entity.components) {
    if (entitiesByComponent_[key] == nil) {
      entitiesByComponent_[key] = [[NSMutableArray alloc] init];
    }
    [entitiesByComponent_[key] addObject:entity];
  }
}



- (void)remove:(Entity *)entity {
  [entities_ removeObjectForKey:entity.uuid];
  for (id key in entity.components) {
    [entitiesByComponent_[key] removeObject:entity];
  }
}



- (void)loadEntityTypesFromFile:(NSString *)filename {
  JSONLoader *loader = [[JSONLoader alloc] init];
  entityTypes_ = [loader loadDictionaryFromFile:filename keyField:@"Type"];
}



- (void)createEntity:(NSNotification *)notification {
  NSString *type             = [notification userInfo][@"type"];
  void (^callback)(Entity *) = [notification userInfo][@"callback"];

  Entity *entity = [self buildEntity:type];
  if (callback) { callback(entity); }
  [self add:entity];
}



- (void)destroyEntity:(NSNotification *)notification {
  Entity *entity           = [notification userInfo][@"entity"];
  void (^callback)(Entity *) = [notification userInfo][@"callback"];

  [self remove:entity];
  if (callback) { callback(entity); }
}



- (Entity *)buildEntity:(NSString *)type {
  NSDictionary * entityData = [entityTypes_ valueForKey:type];
  return [[Entity alloc] initWithDictionary:entityData];
}



- (Entity *)buildAndAddEntity:(NSString *)type {
  Entity *entity = [self buildEntity:type];
  [self add:entity];
  return entity;
}



- (void)queueForDeletion:(Entity *)entity {
  [toBeDeleted_ addObject:entity];
}



- (void)queueForCreation:(Entity *)entity {
  [toBeCreated_ addObject:entity];
}



- (NSArray *)allEntities {
  return [entities_ allValues];
}



- (NSArray *)sortByLayer:(NSArray *)entities {
  NSArray *sorted = [entities sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
    SceneGraph *sceneGraph1 = [obj1 getComponentByString:@"SceneGraph"];
    SceneGraph *sceneGraph2 = [obj2 getComponentByString:@"SceneGraph"];
    if (sceneGraph1.layer < sceneGraph2.layer) {
      return (NSComparisonResult)NSOrderedAscending;
    } else if (sceneGraph1.layer > sceneGraph2.layer) {
      return (NSComparisonResult)NSOrderedDescending;
    } else {
      return (NSComparisonResult)NSOrderedSame;
    }
  }];
  
  return sorted;
}



- (NSArray *)findAllWithComponent:(NSString *)component {
  NSMutableArray *found = [[NSMutableArray alloc] initWithArray:entitiesByComponent_[component]];
  return found;
}



- (NSArray *)findByTeamName:(NSString *)name {
  NSArray *entities     = [self findAllWithComponent:@"Team"];
  NSMutableArray *found = [[NSMutableArray alloc] init];
  for (Entity *entity in entities) {
    Team *team = [entity getComponentByString:@"Team"];
    if ([team.name isEqualToString:name]) {
      [found addObject:entity];
    }
  }

  return found;
}



- (NSArray *)findAllWithinBoundingBox:(BoundingBox *)boundingBox {
  NSMutableArray *found = [[NSMutableArray alloc] init];

  for (Entity *ent in [self findAllWithComponent:@"Transform"]) {
    Transform *transform = [ent getComponentByString:@"Transform"];
    if ([transform isCenterInBoundingBox:boundingBox]) {
      [found addObject:ent];
    }
  }

  return found;
}



- (Entity *)findEntityDisplayedAtPosition:(GLKVector2)target {
  for (Entity *entity in entities_.allValues) {
    Transform *transform = [entity getComponentByString:@"Transform"];
    Collision *collision = [entity getComponentByString:@"Collision"];
    GLKVector2 position  = transform.position;
    float radius         = collision.radius;
    float distance       = GLKVector2Distance(position, target);

    if (distance <= radius) {
      return entity;
    }
  }

  return NULL;
}



- (void)processQueue {
  for (Entity *e in toBeCreated_) {
    [entities_ setObject:e forKey:e.uuid];
  }
  [toBeCreated_ removeAllObjects];

  for (Entity *e in toBeDeleted_) {
    [entities_ removeObjectForKey:e.uuid];
  }
  [toBeDeleted_ removeAllObjects];
}



- (void)update {
  [entities_ enumerateKeysAndObjectsUsingBlock:^(id key, id object, BOOL *stop) {
    [object update];
  }];
}

@end