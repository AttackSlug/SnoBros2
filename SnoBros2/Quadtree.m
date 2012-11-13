//
//  Quadtree.m
//  SnoBros2
//
//  Created by Cjab on 11/12/12.
//  Copyright (c) 2012 Cjab. All rights reserved.
//

#import <GLKit/GLKit.h>
#import "Quadtree.h"
#import "Entity.h"


@implementation Quadtree


- (id)initWithLevel:(int)level bounds:(CGRect)bounds {
  self = [super init];
  if (self) {
    maxObjects_ = 10;
    maxLevels_  = 5;
    entities_   = [[NSMutableArray alloc] init];
    level_      = level;
    bounds_     = bounds;
    [self subdivideRectangle];
  }
  return self;
}



- (void)subdivideRectangle {
  float  x = bounds_.origin.x;
  float  y = bounds_.origin.y;

  float  halfWidth     = bounds_.size.width  / 2;
  float  halfHeight    = bounds_.size.height / 2;
  float  quarterWidth  = halfWidth  / 2;
  float  quarterHeight = halfHeight / 2;

  topLeft_     = CGRectMake(x - quarterWidth, y + quarterHeight,
                            halfWidth, halfHeight);
  topRight_    = CGRectMake(x + quarterWidth, y + quarterHeight,
                            halfWidth, halfHeight);
  bottomLeft_  = CGRectMake(x - quarterWidth, y - quarterHeight,
                            halfWidth, halfHeight);
  bottomRight_ = CGRectMake(x + quarterWidth, y - quarterHeight,
                            halfWidth, halfHeight);
}



- (void)clear {
  [entities_ removeAllObjects];
  for (int i = 0; i < NUM_NODES; i++) {
    [nodes_[i] clear];
    nodes_[i] = NULL;
  }
}



- (void)split {
  nodes_[0] = [[Quadtree alloc] initWithLevel:level_+1 bounds:topLeft_];
  nodes_[1] = [[Quadtree alloc] initWithLevel:level_+1 bounds:topRight_];
  nodes_[2] = [[Quadtree alloc] initWithLevel:level_+1 bounds:bottomLeft_];
  nodes_[3] = [[Quadtree alloc] initWithLevel:level_+1 bounds:bottomRight_];
}



- (int)getIndexOf:(Entity *)entity {
  CGRect rect = [entity.collision boundingBox];

  if (CGRectContainsRect(topLeft_, rect)) {
    return 0;
  } else if (CGRectContainsRect(topRight_, rect)) {
    return 1;
  } else if (CGRectContainsRect(bottomLeft_, rect)) {
    return 2;
  } else if (CGRectContainsRect(bottomRight_, rect)) {
    return 3;
  } else {
    return -1;
  }
}



- (void)insert:(Entity *)entity {
  if (nodes_[0] != NULL) {
    int index = [self getIndexOf:entity];
    if (index != -1) {
      [nodes_[index] insert:entity];
      return;
    }
  }

  [entities_ addObject:entity];

  if (entities_.count > maxObjects_ && level_ < maxLevels_) {
    if (nodes_[0] == NULL) {
      [self split];
    }

    for (Entity *e in entities_) {
      int index = [self getIndexOf:e];
      if (index != -1) {
        [nodes_[index] insert:e];
        [entities_ removeObject:e];
      }
    }
  }
}



- (NSMutableArray *)retrieve:(Entity *)e {
  NSMutableArray *objects = [[NSMutableArray alloc] init];

  int index = [self getIndexOf:e];
  if (index != -1 && nodes_[0] != NULL) {
    [objects addObjectsFromArray:[nodes_[index] retrieve:e]];
  }

  [objects addObjectsFromArray:entities_];
  return objects;
}


@end
