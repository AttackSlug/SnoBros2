//
//  EntityManager.m
//  SnoBros2
//
//  Created by Cjab on 11/17/12.
//  Copyright (c) 2012 Cjab. All rights reserved.
//

#import "EntityManager.h"

#import "Entity.h"
#import "Renderer.h"
#import "Quadtree.h"
#import "Selectable.h"

@implementation EntityManager


- (id)init {
  self = [super init];
  if (self) {
    entities_ = [[NSMutableDictionary alloc] init];
    quadtree_ = [[Quadtree alloc] initWithLevel:5
                                         bounds:CGRectMake(0, 0, 480, 320)];
  }
  return self;
}



- (void)add:(Entity *)entity {
  [entities_ setValue:entity forKey:entity.uuid];
}



- (void)remove:(Entity *)entity {
  [entities_ removeObjectForKey:entity.uuid];
}



- (void)loadFromFile:(NSString *)filename {
  NSError  *error;
  NSString *path  = [[NSBundle mainBundle]
                     pathForResource:filename ofType:@"json"];
  NSString *json = [[NSString alloc] initWithContentsOfFile:path
                                                   encoding:NSUTF8StringEncoding
                                                      error:&error];
  if (error) { NSLog(@"Error: %@", error); return; }

  NSData *data             = [json dataUsingEncoding:NSUTF8StringEncoding];
  NSDictionary *entityData = [NSJSONSerialization JSONObjectWithData:data
                                                             options:NSJSONReadingMutableContainers
                                                               error:&error];
  if (error) { NSLog(@"Error: %@", error); return; }

  if ([entityData isKindOfClass:[NSArray class]]) {
    for (NSDictionary *d in entityData) {
      [self add:[self buildEntityFromDictionary:d]];
    }
  } else {
    [self add:[self buildEntityFromDictionary:entityData]];
  }
}



- (Entity *)buildEntityFromDictionary:(NSDictionary *)data {
  Entity *entity = [[Entity alloc] initWithTag:[data valueForKey:@"tag"]];

  NSDictionary *components = [data valueForKey:@"components"];
  for (NSString *componentName in components) {

    NSString *className  = [[components valueForKey:componentName]
                            valueForKey:@"type"];
    NSString *setterName = [@"set" stringByAppendingString:
                            [[componentName
                              stringByReplacingCharactersInRange:NSMakeRange(0, 1)
                              withString:[[componentName substringToIndex:1]
                                          uppercaseString]]
                             stringByAppendingString:@":"]];

    SEL selector         = NSSelectorFromString(setterName);
    Class componentClass = NSClassFromString(className);

    NSDictionary *attributes = [components valueForKey:componentName];
    Component *component     = [[componentClass alloc] initWithEntity:entity
                                                           dictionary:attributes];

    [entity performSelector:selector withObject:component];
  }

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



//FIXME: I dont' like that this couples the EntityManager to the Renderer.
- (NSArray *)allSortedByLayer {
  NSArray *all = [entities_ allValues];
  NSArray *sorted = [all sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
    Renderer *renderer1 = [obj1 renderer];
    Renderer *renderer2 = [obj2 renderer];
    if (renderer1.layer < renderer2.layer) {
      return (NSComparisonResult)NSOrderedAscending;
    } else if (renderer1.layer > renderer2.layer) {
      return (NSComparisonResult)NSOrderedDescending;
    } else {
      return (NSComparisonResult)NSOrderedSame;
    }
  }];

  return sorted;
}



- (NSArray *)entitiesNear:(Entity *)entity {
  return [quadtree_ retrieve:entity];
}



- (Entity *)findById:(NSString *)entityId {
  return [entities_ objectForKey:entityId];
}



- (NSArray *)findByTag:(NSString *)tag {
  NSMutableArray *found = [[NSMutableArray alloc] init];

  for (Entity *e in [entities_ allValues]) {
    if ([e.tag isEqualToString:tag]) {
      [found addObject:e];
    }
  }

  return found;
}



- (NSArray *)findAllWithComponent:(NSString *)component {
  NSMutableArray *found = [[NSMutableArray alloc] init];

  for (Entity *e in [entities_ allValues]) {
    if ([e performSelector:NSSelectorFromString(component)]) {
      [found addObject:e];
    }
  }

  return found;
}



- (NSArray *)findAllSelected {
  NSMutableArray *found = [[NSMutableArray alloc] init];
  
  for (Entity *e in [self findAllWithComponent:@"selectable"]) {
    if (e.selectable.selected == TRUE) {
      [found addObject:e];
    }
  }
  return found;
}



- (BOOL)isEntitySelected {
  for (Entity *e in [self findAllWithComponent:@"selectable"]) {
    if (e.selectable.selected == TRUE) {
      return TRUE;
    }
  }
  return FALSE;
}



- (void)deselectAll {
  for (Entity *e in [self findAllWithComponent:@"selectable"]) {
    e.selectable.selected = FALSE;
  }
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
  [quadtree_ clear];

  for (Entity *e in [entities_ allValues]) {
    [quadtree_ insert:e];
  }
}

@end