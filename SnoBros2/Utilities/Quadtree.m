//
//  Quadtree.m
//  SnoBros2
//
//  Created by Chad Jablonski on 11/12/12.
//  Copyright (c) 2012 Attack Slug. All rights reserved.
//

#import "Quadtree.h"

#import "BoundingBox.h"

@implementation Quadtree

@synthesize maxObjects = maxObjects_;
@synthesize maxLevels  = maxLevels_;

- (id)initWithBounds:(BoundingBox *)bounds
               level:(int)level
          maxObjects:(int)maxObjects
           maxLevels:(int)maxLevels {
  self = [super init];
  if (self) {
    bounds_     = bounds;
    level_      = level;
    maxObjects_ = maxObjects;
    maxLevels_  = maxLevels;
    objects_    = [[NSMutableArray alloc] init];
  }
  return self;
}



- (id)initWithBounds:(BoundingBox *)bounds {
  return [self initWithBounds:bounds
                        level:0
                   maxObjects:DEFAULT_MAX_OBJECTS
                    maxLevels:DEFAULT_MAX_LEVELS];
}



- (void)clear {
  [objects_ removeAllObjects];
  for (int i = 0; i < NUM_NODES; i++) {
    [nodes_[i] clear];
    nodes_[i] = NULL;
  }
}



- (void)split {
  float  x = bounds_.x;
  float  y = bounds_.y;

  float  halfWidth     = bounds_.width  / 2;
  float  halfHeight    = bounds_.height / 2;
  float  quarterWidth  = halfWidth  / 2;
  float  quarterHeight = halfHeight / 2;

  topLeft_ = [[BoundingBox alloc] initWithX:x - quarterWidth
                                          Y:y + quarterHeight
                                      width:halfWidth
                                     height:halfHeight];
  topRight_ = [[BoundingBox alloc] initWithX:x + quarterWidth
                                           Y:y + quarterHeight
                                       width:halfWidth
                                      height:halfHeight];
  bottomLeft_ = [[BoundingBox alloc] initWithX:x - quarterWidth
                                             Y:y - quarterHeight
                                         width:halfWidth
                                        height:halfHeight];
  bottomRight_ = [[BoundingBox alloc] initWithX:x + quarterWidth
                                              Y:y - quarterHeight
                                          width:halfWidth
                                         height:halfHeight];

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



- (NSArray *)nodesContainingBoundingBox:(BoundingBox *)boundingBox {
  NSMutableArray *found = [[NSMutableArray alloc] init];

  if (nodes_[TOP_LEFT] && [topLeft_ intersectsWith:boundingBox]) {
    [found addObject:nodes_[TOP_LEFT]];
  }

  if (nodes_[TOP_RIGHT] && [topRight_ intersectsWith:boundingBox]) {
    [found addObject:nodes_[TOP_RIGHT]];
  }

  if (nodes_[BOTTOM_LEFT] && [bottomLeft_ intersectsWith:boundingBox]) {
    [found addObject:nodes_[BOTTOM_LEFT]];
  }

  if (nodes_[BOTTOM_RIGHT] && [bottomRight_ intersectsWith:boundingBox]) {
    [found addObject:nodes_[BOTTOM_RIGHT]];
  }

  return found;
}



- (void)addObject:(id)object withBoundingBox:(BoundingBox *)boundingBox {

  if ([self isNotLeafNode]) {
    for (Quadtree *node in [self nodesContainingBoundingBox:boundingBox]) {
      [node addObject:object withBoundingBox:boundingBox];
    }
    return;
  }

  [objects_ addObject:@{@"boundingBox": boundingBox, @"object": object}];

  if (objects_.count > maxObjects_ && level_ < maxLevels_) {
    if ([self isLeafNode]) {
      [self split];
    }

    [self redistributeObjects];
  }
}



- (BOOL)removeObject:(id)object {

  if (![self isLeafNode]) {

    for (int i = 0; i < NUM_NODES; i++) {
      if([nodes_[i] removeObject:object]) {
        return YES;
      }
    }

  } else {

    for (NSDictionary *entry in objects_) {
      if (object == entry[@"object"]) {
        [objects_ removeObject:entry];
        return YES;
      }
    }

  }

  return NO;
}



/*
- (void)updateObject:(id)object withBoundingBox:(BoundingBox *)boundingBox {
  BOOL wasRemoved     = [self removeObject:object];
  BOOL isWithinBounds = [bounds_ intersectsWith:boundingBox];


  if (wasRemoved && isWithinBounds) {
    [self addObject:object withBoundingBox:boundingBox];
  } else if (!isWithingBounds) {

  } else {
    for (int i = 0; i < NUM_NODES; i++) {
      [nodes_[i] updateObject:object withBoundingBox:boundingBox];
    }
  }
}
*/


- (void)redistributeObjects {
  for (NSDictionary *entry in objects_) {
    id object                = entry[@"object"];
    BoundingBox *boundingBox = entry[@"boundingBox"];
    for (Quadtree *node in [self nodesContainingBoundingBox:boundingBox]) {
      [node addObject:object withBoundingBox:boundingBox];
    }
  }
  [objects_ removeAllObjects];
}



- (NSArray *)retrieveCollisionGroups {
  NSMutableArray *found = [[NSMutableArray alloc] initWithCapacity:1024];

  if ([self isLeafNode]) {
    NSMutableArray *group = [[NSMutableArray alloc] initWithCapacity:15];
    for (NSDictionary *entry in objects_) {
      [group addObject:entry[@"object"]];
    }
    [found addObject:group];
    return found;
  }


  for (int i = 0; i < NUM_NODES; i++) {
    [found addObjectsFromArray:[nodes_[i] retrieveCollisionGroups]];
  }

  return found;
}



- (NSMutableArray *)retrieveObjectsNear:(BoundingBox *)boundingBox {
  NSMutableArray *found = [[NSMutableArray alloc] init];

  NSArray *nodes = [self nodesContainingBoundingBox:boundingBox];
  for (Quadtree *node in nodes) {
    [found addObjectsFromArray:[node retrieveObjectsNear:boundingBox]];
  }

  for (NSDictionary *entry in objects_) {
    [found addObject:entry[@"object"]];
  }

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