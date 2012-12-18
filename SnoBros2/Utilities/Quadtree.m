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
@synthesize bounds     = bounds_;

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
    objects_    = [[NSMutableArray alloc] initWithCapacity:maxObjects + 5];
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
  BoundingBox *quads[NUM_NODES];

  float  x = bounds_.x;
  float  y = bounds_.y;

  float  halfWidth     = bounds_.width  / 2;
  float  halfHeight    = bounds_.height / 2;
  float  quarterWidth  = halfWidth  / 2;
  float  quarterHeight = halfHeight / 2;

  quads[TOP_LEFT]     = [[BoundingBox alloc] initWithX:x - quarterWidth
                                                     Y:y + quarterHeight
                                                 width:halfWidth
                                                height:halfHeight];
  quads[TOP_RIGHT]    = [[BoundingBox alloc] initWithX:x + quarterWidth
                                                     Y:y + quarterHeight
                                                 width:halfWidth
                                                height:halfHeight];
  quads[BOTTOM_LEFT]  = [[BoundingBox alloc] initWithX:x - quarterWidth
                                                     Y:y - quarterHeight
                                                 width:halfWidth
                                                height:halfHeight];
  quads[BOTTOM_RIGHT] = [[BoundingBox alloc] initWithX:x + quarterWidth
                                                     Y:y - quarterHeight
                                                 width:halfWidth
                                                height:halfHeight];

  for (int i = 0; i < NUM_NODES; i++) {
    nodes_[i] = [[Quadtree alloc] initWithBounds:quads[i]
                                           level:level_ + 1
                                      maxObjects:maxObjects_
                                       maxLevels:maxLevels_];
  }
}



- (NSArray *)nodesContainingBoundingBox:(BoundingBox *)boundingBox {
  NSMutableArray *found = [[NSMutableArray alloc] initWithCapacity:NUM_NODES];

  for (int i = 0; i < NUM_NODES; i++) {
    Quadtree *child = nodes_[i];
    if ([child.bounds intersectsWith:boundingBox]) {
      [found addObject:child];
    }
  }

  return found;
}



- (void)addObject:(id)object withBoundingBox:(BoundingBox *)boundingBox {

  if (![self isLeafNode]) {
    for (Quadtree *node in [self nodesContainingBoundingBox:boundingBox]) {
      [node addObject:object withBoundingBox:boundingBox];
    }
    return;
  }

  [objects_ addObject:@{@"boundingBox": boundingBox, @"object": object}];

  if (objects_.count > maxObjects_ && level_ < maxLevels_) {
    [self split];
    [self redistributeObjects];
  }
}



- (BOOL)removeObject:(id)object {
  BOOL didRemoveObject = NO;

  if (![self isLeafNode]) {

    for (int i = 0; i < NUM_NODES; i++) {
      if([nodes_[i] removeObject:object]) {
        didRemoveObject = YES;
      }
    }

  } else {

    for (int i = 0; i < objects_.count; i++) {
      NSDictionary *entry = objects_[i];
      if (object == entry[@"object"]) {
        [objects_ removeObject:entry];
        didRemoveObject = YES;
        i -= 1;
      }
    }

  }

  return didRemoveObject;
}



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



- (void)retrieveCollisionGroups:(NSMutableArray *)groups {
  if ([self isLeafNode]) {
    [groups addObject:objects_];
  } else {
    for (int i = 0; i < NUM_NODES; i++) {
      [nodes_[i] retrieveCollisionGroups:groups];
    }
  }
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



- (BOOL)isLeafNode {
  for (int i = 0; i < NUM_NODES; i++) {
    if (nodes_[i]) {
      return NO;
    }
  }
  return YES;
}

@end