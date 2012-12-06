//
//  PathfindingSystem.m
//  SnoBros2
//
//  Created by Chad Jablonski on 12/3/12.
//  Copyright (c) 2012 Attack Slug. All rights reserved.
//

#import "PathfindingSystem.h"

#import "MapGrid.h"
#import "MapNode.h"
#import "Pathfinder.h"

#import "Entity.h"
#import "EntityManager.h"

#import "Transform.h"
#import "Pathfinding.h"

@implementation PathfindingSystem

- (id)initWithEntityManager:(EntityManager *)entityManager {
  self = [super init];
  if (self) {
    entityManager_ = entityManager;

    CGRect bounds  = CGRectMake(0.f, 0.f, 1024.f, 1024.f);
    CGSize size    = CGSizeMake(32.f, 32.f);
    map_           = [[MapGrid alloc] initWithBounds:bounds nodeSize:size];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(findPath:)
                                                 name:@"findPath"
                                               object:nil];
  }
  return self;
}



- (void)findPath:(NSNotification *)notification {
  NSDictionary *data        = [notification userInfo];
  Entity       *entity      = data[@"entity"];
  Pathfinding  *pathfinding = [entity getComponentByString:@"Pathfinding"];
  GLKVector2    target;
  [data[@"target"] getValue:&target];

  pathfinding.waypoints = [self findPathFor:entity to:target];

  if (pathfinding.waypoints.count > 1) {
    NSString   *walkTo       = [entity.uuid stringByAppendingString:@"|walkTo"];
    GLKVector2  nextWaypoint = [pathfinding nextWaypoint];

    NSDictionary *walkToData = @{ @"target": [NSValue value:&nextWaypoint
                                               withObjCType:@encode(GLKVector2)]};
    [[NSNotificationCenter defaultCenter] postNotificationName:walkTo
                                                        object:self
                                                      userInfo:walkToData];
  }
}



- (NSArray *)findPathFor:(Entity *)entity to:(GLKVector2)target {
  Transform  *transform    = [entity getComponentByString:@"Transform"];
  Heuristic   heuristic    = [Pathfinder manhattanDistance];
  Pathfinder *pathfinder   = [[Pathfinder alloc] initWithHeuristic:heuristic
                                                     entityManager:entityManager_];
  GLKVector2 position    = transform.position;
  MapNode *start         = [map_ findNodeByRealCoordinates:position];
  MapNode *end           = [map_ findNodeByRealCoordinates:target];

  NSMutableArray *vectorPath = [[NSMutableArray alloc] init];
  NSArray *nodePath = [pathfinder findPathFrom:start to:end];

  for (MapNode *node in nodePath) {
    GLKVector2 nodePosition = node.position;
    NSValue *vector = [NSValue value:&nodePosition
                        withObjCType:@encode(GLKVector2)];
    [vectorPath addObject:vector];
  }

  return vectorPath;
}



- (void)update {
  NSArray *entities = [entityManager_ findAllWithComponent:@"Pathfinding"];

  for (Entity *entity in entities) {
    Pathfinding *pathfinding   = [entity getComponentByString:@"Pathfinding"];
    GLKVector2 currentWaypoint = [pathfinding currentWaypoint];

    if ([self isEntity:entity atWaypoint:currentWaypoint] && [pathfinding hasNextWaypoint]) {
      GLKVector2 nextWaypoint = [pathfinding nextWaypoint];
      NSString  *walkTo       = [entity.uuid stringByAppendingString:@"|walkTo"];
      NSValue   *target       = [NSValue value:&nextWaypoint
                                  withObjCType:@encode(GLKVector2)];

      NSDictionary *data = @{ @"target": target };
      [[NSNotificationCenter defaultCenter] postNotificationName:walkTo
                                                          object:self
                                                        userInfo:data];
    }
  }
}



- (bool)isEntity:(Entity *)entity atWaypoint:(GLKVector2)waypoint {
  Transform *transform = [entity getComponentByString:@"Transform"];
  float distance = GLKVector2Distance(transform.position, waypoint);

  return [ASFloat is:distance lessThanOrEqualTo:4.f];
}

@end