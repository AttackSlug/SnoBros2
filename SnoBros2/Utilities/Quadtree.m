//
//  Quadtree.m
//  SnoBros2
//
//  Created by Chad Jablonski on 11/12/12.
//  Copyright (c) 2012 Attack Slug. All rights reserved.
//

#import "Quadtree.h"

@implementation Quadtree

@synthesize maxObjects = maxObjects_;
@synthesize maxLevels  = maxLevels_;

- (id)initWithBounds:(CGRect)bounds
               level:(int)level
          maxObjects:(int)maxObjects
           maxLevels:(int)maxLevels {
  self = [super init];
  if (self) {
    bounds_     = bounds;
    level_      = level;
    maxObjects_ = maxObjects;
    maxLevels_  = maxLevels;
    objects_    = [[NSMutableDictionary alloc] init];

    [self subdivideRectangle];
  }
  return self;
}



- (id)initWithBounds:(CGRect)bounds {
  return [self initWithBounds:bounds
                        level:0
                   maxObjects:DEFAULT_MAX_OBJECTS
                    maxLevels:DEFAULT_MAX_LEVELS];
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
  [objects_ removeAllObjects];
  for (int i = 0; i < NUM_NODES; i++) {
    [nodes_[i] clear];
    nodes_[i] = NULL;
  }
}



- (void)split {
  nodes_[TOP_LEFT]     = [[Quadtree alloc] initWithBounds:topLeft_
                                                    level:level_ + 1
                                               maxObjects:maxObjects_
                                                maxLevels:maxLevels_];
  nodes_[TOP_RIGHT]    = [[Quadtree alloc] initWithBounds:topRight_
                                                    level:level_ + 1
                                               maxObjects:maxObjects_
                                                maxLevels:maxLevels_];
  nodes_[BOTTOM_LEFT]  = [[Quadtree alloc] initWithBounds:bottomLeft_
                                                    level:level_ + 1
                                               maxObjects:maxObjects_
                                                maxLevels:maxLevels_];
  nodes_[BOTTOM_RIGHT] = [[Quadtree alloc] initWithBounds:bottomRight_
                                                    level:level_ + 1
                                               maxObjects:maxObjects_
                                                maxLevels:maxLevels_];
}



- (NSArray *)nodesContainingBoundingBox:(CGRect)boundingBox {
  NSMutableArray *found = [[NSMutableArray alloc] init];

  if (nodes_[TOP_LEFT] && CGRectIntersectsRect(topLeft_, boundingBox)) {
    [found addObject:nodes_[TOP_LEFT]];
  }

  if (nodes_[TOP_RIGHT] && CGRectIntersectsRect(topRight_, boundingBox)) {
    [found addObject:nodes_[TOP_RIGHT]];
  }

  if (nodes_[BOTTOM_LEFT] && CGRectIntersectsRect(bottomLeft_, boundingBox)) {
    [found addObject:nodes_[BOTTOM_LEFT]];
  }

  if (nodes_[BOTTOM_RIGHT] && CGRectIntersectsRect(bottomRight_, boundingBox)) {
    [found addObject:nodes_[BOTTOM_RIGHT]];
  }

  return found;
}



- (void)addObject:(id)object withBoundingBox:(CGRect)boundingBox {

  if ([self isNotLeafNode]) {
    for (Quadtree *node in [self nodesContainingBoundingBox:boundingBox]) {
      [node addObject:object withBoundingBox:boundingBox];
    }
    return;
  }

  NSValue *key = [NSValue value:&boundingBox withObjCType:@encode(CGRect)];
  [objects_ setObject:object forKey:key];

  if (objects_.count >= maxObjects_ && level_ < maxLevels_) {
    if ([self isLeafNode]) {
      [self split];
    }

    [self redistributeObjects];
  }
}



- (void)redistributeObjects {
  CGRect boundingBox;
  for (id key in objects_) {
    [key getValue:&boundingBox];
    id object = objects_[key];
    for (Quadtree *node in [self nodesContainingBoundingBox:boundingBox]) {
      [node addObject:object withBoundingBox:boundingBox];
    }
  }
}



- (NSMutableArray *)retrieveObjectsNear:(CGRect)boundingBox {
  NSMutableArray *found = [[NSMutableArray alloc] init];


  NSArray *nodes = [self nodesContainingBoundingBox:boundingBox];
  for (Quadtree *node in nodes) {
    [found addObjectsFromArray:[node retrieveObjectsNear:boundingBox]];
  }

  [found addObjectsFromArray:[objects_ allValues]];

  return found;
}



- (bool)isLeafNode {
  for (int i = 0; i < NUM_NODES; i++) {
    if (nodes_[i]) {
      return false;
    }
  }
  return true;
}



- (bool)isNotLeafNode {
  return ![self isLeafNode];
}

@end