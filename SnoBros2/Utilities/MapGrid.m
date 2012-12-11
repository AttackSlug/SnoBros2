//
//  MapGrid.m
//  SnoBros2
//
//  Created by Chad Jablonski on 11/29/12.
//  Copyright (c) 2012 Attack Slug. All rights reserved.
//

#import <GLKit/GLKit.h>

#import "MapGrid.h"

#import "MapNode.h"
#import "BoundingBox.h"

@implementation MapGrid

- (id)initWithBounds:(BoundingBox *)bounds nodeSize:(CGSize)nodeSize {
  self = [super init];
  if (self) {
    bounds_   = bounds;
    nodeSize_ = nodeSize;
    nodes_    = [self buildGridWithBounds:bounds nodeSize:nodeSize];
    [self buildGraph];
  }
  return self;
}



- (NSArray *)buildGridWithBounds:(BoundingBox *)bounds nodeSize:(CGSize)nodeSize {
  int gridWidth  = bounds.width  / nodeSize.width;
  int gridHeight = bounds.height / nodeSize.height;

  NSMutableArray *nodes = [[NSMutableArray alloc] init];
  for (int i = 0; i < gridWidth; i++) {
    NSMutableArray *column = [[NSMutableArray alloc] init];
    for (int j = 0; j < gridHeight; j++) {

      GLKVector2 position = GLKVector2Make((i * nodeSize.width)  + (nodeSize.width / 2),
                                           (j * nodeSize.height) + (nodeSize.height / 2));

      MapNode *node = [[MapNode alloc] initWithPosition:position
                                                   size:nodeSize];

      [column addObject:node];
    }
    [nodes addObject:column];
  }

  return nodes;
}



- (void)buildGraph {
  for (int x = 0; x < nodes_.count; x++) {
    NSArray *column = nodes_[x];
    for (int y = 0; y < column.count; y++) {
      MapNode *current  = nodes_[x][y];
      current.neighbors = [self getNeighborsOfGridCoordinatesX:x Y:y];
    }
  }
}



- (GLKVector2)gridCoordinatesFromRealCoordinates:(GLKVector2)realCoordinates {
  int gridWidth  = bounds_.width  / nodeSize_.width;
  int gridHeight = bounds_.height / nodeSize_.height;

  int x = (realCoordinates.x / nodeSize_.width);
  int y = (realCoordinates.y / nodeSize_.height);

  x = (x < 0 ? 0 : x);
  y = (y < 0 ? 0 : y);

  x = (x >= gridWidth  ? gridWidth  - 1 : x);
  y = (y >= gridHeight ? gridHeight - 1 : y);

  return GLKVector2Make(x, y);
}



- (MapNode *)findNodeByGridCoordinatesX:(int)x Y:(int)y {
  if (x < 0 || x >= nodes_.count) {
    return nil;
  }

  NSArray *column = nodes_[x];
  if (y < 0 || y >= column.count) {
    return nil;
  }

  return nodes_[x][y];
}



- (MapNode *)findNodeByRealCoordinates:(GLKVector2)realCoordinates {
  GLKVector2 gridCoords =
    [self gridCoordinatesFromRealCoordinates:realCoordinates];

  return [self findNodeByGridCoordinatesX:gridCoords.x Y:gridCoords.y];
}



- (NSMutableArray *)getNeighborsOfGridCoordinatesX:(int)x Y:(int)y {
  NSMutableArray *neighbors = [[NSMutableArray alloc] init];
  for (int i = x - 1; i <= x + 1; i++) {
    for (int j = y + 1; j >= y - 1; j--) {

      if (i == x && j == y) {
        // In this case we are looking at the node itself, not a neighbor
        continue;
      }

      MapNode *neighbor = [self findNodeByGridCoordinatesX:i Y:j];
      if (neighbor) {
        [neighbors addObject:neighbor];
      }

    }
  }

  return neighbors;
}

@end