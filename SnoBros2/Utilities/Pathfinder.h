//
//  Pathfinder.h
//  SnoBros2
//
//  Created by Chad Jablonski on 12/1/12.
//  Copyright (c) 2012 Attack Slug. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MapNode;
@class MapGrid;
@class EntityManager;
@class Quadtree;
@class Entity;

typedef float(^Heuristic)(MapNode *, MapNode *, int);

@interface Pathfinder : NSObject {
  EntityManager *entityManager_;
  Heuristic      heuristic_;
  Quadtree      *obstacleTree_;
}

+ (Heuristic)manhattanDistance;
+ (Heuristic)euclidianDistance;
+ (Heuristic)diagonalDistance;

- (id)initWithHeuristic:(Heuristic)heuristic
          entityManager:(EntityManager *)entityManager;

- (NSArray *)findPathFrom:(MapNode *)start
                       to:(MapNode *)end
                forEntity:(Entity *)entity;
- (NSArray *)buildPathWithEnd:(MapNode *)end;
- (bool)isNodeTraversable:(MapNode *)node;

@end