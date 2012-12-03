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

typedef float(^Heuristic)(MapNode *, MapNode *, int);

@interface Pathfinder : NSObject {
  MapGrid   *map_;
  Heuristic  heuristic_;
}

+ (Heuristic)manhattanDistance;
+ (Heuristic)euclidianDistance;
+ (Heuristic)diagonalDistance;

- (id)initWithMap:(MapGrid *)map andHeuristic:(Heuristic)heuristic;

- (void)findPathFrom:(MapNode *)start to:(MapNode *)end;

@end