//
//  MapNode.m
//  SnoBros2
//
//  Created by Cjab on 11/29/12.
//  Copyright (c) 2012 Attack Slug. All rights reserved.
//

#import "MapNode.h"

@implementation MapNode

@synthesize parent    = parent_;
@synthesize neighbors = neighbors_;
@synthesize position  = position_;
@synthesize g         = g_;
@synthesize h         = h_;
@synthesize f         = f_;
@synthesize isTraversable = isTraversable_;

- (id)init {
  self = [super init];
  if (self) {
    isTraversable_ = true;
    neighbors_ = [[NSMutableArray alloc] init];
  }
  return self;
}



- (float)movementCostTo:(MapNode *)neighbor {
  return GLKVector2Distance(position_, neighbor.position);
}



// FIXME: This will need to be replaced with a method determining if any
//        obstacles exist at this node.
//- (bool)isTraversable {
//  return true;
//}



- (NSArray *)findNeighbors {
  NSMutableArray *neighborsFound = [[NSMutableArray alloc] init];
  for (MapNode *node in neighbors_) {
    if (node) {
      [neighborsFound addObject:node];
    }
  }
  return neighborsFound;
}

@end