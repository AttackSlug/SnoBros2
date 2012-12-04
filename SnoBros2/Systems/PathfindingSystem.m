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
#import "Float.h"
#import "Pathfinding.h"

@implementation PathfindingSystem

- (id)initWithEntityManager:(EntityManager *)entityManager {
  self = [super init];
  if (self) {
    entityManager_ = entityManager;

    CGRect bounds  = CGRectMake(-512.f, -512.f, 1024.f, 1024.f);
    CGSize size    = CGSizeMake(8.f, 8.f);
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
}



- (NSArray *)findPathFor:(Entity *)entity to:(GLKVector2)target {
  Transform  *transform    = [entity getComponentByString:@"Transform"];
  Heuristic   heuristic    = [Pathfinder manhattanDistance];
  Pathfinder *pathfinder   = [[Pathfinder alloc] initWithHeuristic:heuristic
                                                     entityManager:entityManager_];
  GLKVector2 position    = transform.position;
  MapNode *start         = [map_ findNodeByX:position.x Y:position.y];
  //MapNode *end           = [map_ findNodeByX:target.x   Y:target.y];
  MapNode *end           = [map_ findNodeByX:100   Y:100];


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

    if ([self isEntity:entity atWaypoint:currentWaypoint]) {
      GLKVector2 nextWaypoint = [pathfinding nextWaypoint];
      NSString *walkTo   = [entity.uuid stringByAppendingString:@"|walkTo"];
      NSValue  *target   = [NSValue value:&nextWaypoint
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

  return [Float is:distance lessThanOrEqualTo:1.f];
}

@end