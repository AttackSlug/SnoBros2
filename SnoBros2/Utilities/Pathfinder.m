//
//  Pathfinder.m
//  SnoBros2
//
//  Created by Cjab on 12/1/12.
//  Copyright (c) 2012 Attack Slug. All rights reserved.
//

#import "Pathfinder.h"

#import "MapNode.h"
#import "MapGrid.h"

@implementation Pathfinder

- (id)initWithMap:(MapGrid *)map andHeuristic:(Heuristic)heuristic {
  self = [super init];
  if (self) {
    map_       = map;
    heuristic_ = heuristic;
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
  MapNode *cheapest = nodes[0];
  for (MapNode *node in nodes) {
    if (node.f <= cheapest.f) {
      cheapest = node;
    }
  }
  return cheapest;
}



- (void)findPathFrom:(MapNode *)start to:(MapNode *)end {
  NSMutableArray *open    = [[NSMutableArray alloc] init];
  NSMutableArray *closed  = [[NSMutableArray alloc] init];
  MapNode        *current = start;
  [open addObject:start];

  while (open.count > 0) {

    current = [self findCheapestNodeIn:open];
    [open removeObject:current];
    [closed addObject:current];

    if (current == end) {
      NSLog(@"Found the end!");
      return;
    }

    NSArray *neighbors = [current findNeighbors];
    for (MapNode *neighbor in neighbors) {
      if ([closed containsObject:neighbor] || ![neighbor isTraversable]) {
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
}

@end