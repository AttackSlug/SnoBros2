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

@implementation MapGrid

- (id)initWithBounds:(CGRect)bounds nodeSize:(CGSize)nodeSize {
  self = [super init];
  if (self) {
    bounds_   = bounds;
    nodeSize_ = nodeSize;

    float width  = bounds_.size.width  / nodeSize.width;
    float height = bounds_.size.height / nodeSize.height;

    nodes_ = [[NSMutableArray alloc] init];
    for (int i = 0; i < width; i++) {
      NSMutableArray *column = [[NSMutableArray alloc] init];
      for (int j = 0; j < height; j++) {
        GLKVector2 position = GLKVector2Make(i * nodeSize.width,
                                             j * nodeSize.height);
        MapNode *node = [[MapNode alloc] initWithPosition:position
                                                     size:nodeSize];
        node.position = GLKVector2Make(i, j);
        [column addObject:node];
      }
      [nodes_ addObject:column];
    }

    [self buildGraph];
  }
  return self;
}



- (void)buildGraph {
  for (int x = 0; x < nodes_.count; x++) {
    NSArray *column = nodes_[x];
    for (int y = 0; y < column.count; y++) {
      MapNode *current  = nodes_[x][y];
      current.neighbors = [self getNeighborsOfX:x Y:y];
    }
  }
}



- (MapNode *)findNodeByX:(float)x Y:(float)y {
  int xIndex = (bounds_.size.width  / 2) + x;
  int yIndex = (bounds_.size.height / 2) + y;

  if (xIndex < 0 || xIndex >= nodes_.count) {
    return nil;
  }

  NSArray *column = nodes_[xIndex];
  if (yIndex < 0 || yIndex >= column.count) {
    return nil;
  }

  return nodes_[xIndex][yIndex];
}



// WARNING: This is a very inefficient way to replace a node in the graph.
//          The primary purpose of this method is testing. If it is needed
//          for other purposes some time should be spent to improve it.
- (MapNode *)setNodeAtX:(int)x Y:(int)y to:(MapNode *)replacement {
  if (x < 0 || x >= nodes_.count) {
    return nil;
  }

  NSArray *column = nodes_[x];
  if (y < 0 || y >= column.count) {
    return nil;
  }

  nodes_[x][y] = replacement;
  [self buildGraph];

  return nodes_[x][y];
}



- (NSMutableArray *)getNeighborsOfX:(int)x Y:(int)y {
  NSMutableArray *neighbors = [[NSMutableArray alloc] init];
  for (int i = x - 1; i <= x + 1; i++) {
    for (int j = y + 1; j >= y - 1; j--) {

      if (i == x && j == y) {
        // In this case we are looking at the node itself, not a neighbor
        continue;
      }

      MapNode *neighbor = [self findNodeByX:i Y:j];
      if (neighbor) {
        [neighbors addObject:neighbor];
      }

    }
  }

  return neighbors;
}

@end