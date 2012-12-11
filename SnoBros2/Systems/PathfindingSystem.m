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
#import "BoundingBox.h"

#import "Entity.h"
#import "EntityManager.h"

#import "Transform.h"
#import "Pathfinding.h"

@implementation PathfindingSystem

- (id)initWithEntityManager:(EntityManager *)entityManager {
  self = [super init];
  if (self) {
    entityManager_ = entityManager;

    GLKVector2 origin = GLKVector2Make(512.f, 512.f);
    CGSize boundsSize = CGSizeMake(1024.f, 1024.f);
    BoundingBox *bounds = [[BoundingBox alloc] initWithOrigin:origin
                                                         size:boundsSize];
    CGSize size    = CGSizeMake(32.f, 32.f);
    map_           = [[MapGrid alloc] initWithBounds:bounds nodeSize:size];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleFindPath:)
                                                 name:@"findPath"
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleArrivedAtTarget:)
                                                 name:@"arrivedAtTarget" object:nil];
  }
  return self;
}



- (void)handleFindPath:(NSNotification *)notification {
  NSDictionary *data        = [notification userInfo];
  Entity       *entity      = data[@"entity"];
  Pathfinding  *pathfinding = [entity getComponentByString:@"Pathfinding"];
  GLKVector2    target;
  [data[@"target"] getValue:&target];

  pathfinding.waypoints = [self findPathFor:entity to:target];

  if (pathfinding.waypoints.count > 1) {
    GLKVector2  nextWaypoint = [pathfinding nextWaypoint];

    NSDictionary *walkToData = @{
      @"entity":  entity,
      @"target": [NSValue value:&nextWaypoint
                   withObjCType:@encode(GLKVector2)]
    };
    [[NSNotificationCenter defaultCenter] postNotificationName:@"walkTo"
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
  NSArray *nodePath = [pathfinder findPathFrom:start to:end forEntity:entity];

  for (MapNode *node in nodePath) {
    GLKVector2 nodePosition = node.position;
    NSValue *vector = [NSValue value:&nodePosition
                        withObjCType:@encode(GLKVector2)];
    [vectorPath addObject:vector];
  }

  if (vectorPath.count > 0) {
    // The target itself should be the final waypoint
    [vectorPath removeLastObject];
    NSValue *vector = [NSValue value:&target
                        withObjCType:@encode(GLKVector2)];
    [vectorPath addObject:vector];
  }

  return vectorPath;
}



- (void)handleArrivedAtTarget:(NSNotification *)notification {
  Entity *entity = [notification userInfo][@"entity"];
  [self arrivedAtTarget:entity];
}



- (void)arrivedAtTarget:(Entity *)entity {
  Pathfinding *pathfinding = [entity getComponentByString:@"Pathfinding"];

  if ([pathfinding hasNextWaypoint]) {
    GLKVector2 nextWaypoint = [pathfinding nextWaypoint];
    NSValue   *target       = [NSValue value:&nextWaypoint
                                withObjCType:@encode(GLKVector2)];

    NSDictionary *data = @{@"entity": entity, @"target": target};
    [[NSNotificationCenter defaultCenter] postNotificationName:@"walkTo"
                                                        object:self
                                                      userInfo:data];
  }
}

@end