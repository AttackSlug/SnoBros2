//
//  Pathfinder.m
//  SnoBros2
//
//  Created by Chad Jablonski on 12/1/12.
//  Copyright (c) 2012 Attack Slug. All rights reserved.
//

#import "Pathfinder.h"

#import "MapNode.h"
#import "Quadtree.h"
#import "EntityManager.h"

@implementation Pathfinder

- (id)initWithHeuristic:(Heuristic)heuristic
          entityManager:(EntityManager *)entityManager {
  self = [super init];
  if (self) {
    heuristic_     = heuristic;
    entityManager_ = entityManager;

    //FIXME: Temporarily hardcoded bounds
    CGRect bounds  = CGRectMake(0.f, 0.f, 1024.f, 1024.f);
    obstacleTree_  = [[Quadtree alloc] initWithLevel:5 bounds:bounds];
  }
  return self;
}



+ (Heuristic)manhattanDistance {
  return ^(MapNode *start, MapNode *end, int cost) {
    float dx = abs(end.position.x - start.position.x);
    float dy = abs(end.position.y - start.position.y);
    return (float)(cost * (dx + dy));
  };
}



+ (Heuristic)euclidianDistance {
  return ^(MapNode *start, MapNode *end, int cost) {
    float dx = end.position.x - start.position.x;
    float dy = end.position.y - start.position.y;
    return (float)(cost * sqrt(dx * dx + dy * dy));
  };
}



+ (Heuristic)diagonalDistance {
  return ^(MapNode *start, MapNode *end, int cost) {
    float dx       = abs(end.position.x - start.position.x);
    float dy       = abs(end.position.y - start.position.y);
    float diag     = MIN(dx, dy);
    float straight = dx + dy;
    float diagCost = sqrt(cost * cost + cost * cost);
    return (float)(diagCost * diag + cost * (straight - 2 * diag));
  };
}



- (MapNode *)findCheapestNodeIn:(NSArray *)nodes {
  if (!nodes.count) { return nil; }
  
  MapNode *cheapest = nodes[0];
  for (MapNode *node in nodes) {
    if (node.f <= cheapest.f) {
      cheapest = node;
    }
  }
  return cheapest;
}



- (NSArray *)findPathFrom:(MapNode *)start to:(MapNode *)end {
  NSMutableArray *open    = [[NSMutableArray alloc] init];
  NSMutableArray *closed  = [[NSMutableArray alloc] init];
  MapNode        *current = start;
  [open addObject:start];

  [self updateObstacleTree];

  start.parent = nil;

  while (open.count > 0) {

    current = [self findCheapestNodeIn:open];
    [open removeObject:current];
    [closed addObject:current];

    if (current == end) {
      return [self buildPathWithEnd:end];
    }

    NSArray *neighbors = [current findNeighbors];
    for (MapNode *neighbor in neighbors) {
      if ([closed containsObject:neighbor] || ![self isNodeTraversable:neighbor]) {
        continue;
      }

      float tentativeG = current.g + [current movementCostTo:neighbor];
      bool  inOpenSet  = [open containsObject:neighbor];

      if (!inOpenSet || tentativeG < neighbor.g) {
        neighbor.g      = tentativeG;
        neighbor.h      = heuristic_(neighbor, end, 1);
        neighbor.f      = neighbor.g + neighbor.h;
        neighbor.parent = current;
        if (!inOpenSet) {
          [open addObject:neighbor];
        }
      }
    }
  }

  return nil;
}



- (NSArray *)buildPathWithEnd:(MapNode *)end {
  MapNode *waypoint = end;

  NSMutableArray *path = [[NSMutableArray alloc] init];
  while (waypoint) {
    [path addObject:waypoint];
    waypoint = waypoint.parent;
  }

  return [[path reverseObjectEnumerator] allObjects];
}



- (void)updateObstacleTree {
  NSArray *entities = [entityManager_ findAllWithComponent:@"Collision"];
  for (Entity *entity in entities) {
    [obstacleTree_ insert:entity];
  }
}



- (bool)isNodeTraversable:(MapNode *)node {
  NSArray *obstacles = [obstacleTree_ retrieveRectanglesNear:node.boundingBox];


  for (NSValue *rectValue in obstacles) {
    CGRect rectangle;
    [rectValue getValue:&rectangle];
    if (CGRectIntersectsRect(rectangle, node.boundingBox)) {
      return false;
    }
  }

  return true;
}

@end