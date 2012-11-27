//
//  SceneNode.m
//  SnoBros2
//
//  Created by Tanoy Sinha on 11/27/12.
//  Copyright (c) 2012 Attack Slug. All rights reserved.
//

#import "SceneNode.h"

@implementation SceneNode

@synthesize parent = parent_;

- (void)addChild:(SceneNode *)child {
  child.parent = self;
  [children_ addObject:child];
}



- (void)addChildren:(NSMutableArray *)children {
  for (SceneNode *child in children) {
    [self addChild:child];
  }
}



- (GLKMatrix4)modelViewMatrix {
  if (parent_ != nil) {
    return GLKMatrix4Multiply(parent_.modelViewMatrix, modelViewMatrix_);
  }
  return modelViewMatrix_;
}

@end
