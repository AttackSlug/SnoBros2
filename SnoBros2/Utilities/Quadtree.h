//
//  Quadtree.h
//  SnoBros2
//
//  Created by Chad Jablonski on 11/12/12.
//  Copyright (c) 2012 Attack Slug. All rights reserved.
//

#import <Foundation/Foundation.h>

#define DEFAULT_MAX_OBJECTS 10
#define DEFAULT_MAX_LEVELS   5
#define NUM_NODES            4

enum quadrant { TOP_LEFT, TOP_RIGHT, BOTTOM_LEFT, BOTTOM_RIGHT };

@interface Quadtree : NSObject {
  int maxObjects_;
  int maxLevels_;
  int level_;

  CGRect bounds_;
  CGRect topLeft_;
  CGRect topRight_;
  CGRect bottomLeft_;
  CGRect bottomRight_;

  Quadtree            *nodes_[NUM_NODES];
  NSMutableDictionary *objects_;
}

@property (nonatomic, readonly) int maxObjects;
@property (nonatomic, readonly) int maxLevels;

- (id)initWithBounds:(CGRect)bounds
               level:(int)level
          maxObjects:(int)maxObjects
           maxLevels:(int)maxLevels;
- (id)initWithBounds:(CGRect)bounds;

- (void)clear;
- (void)split;
- (bool)isLeafNode;
- (bool)isNotLeafNode;
- (void)subdivideRectangle;
- (void)redistributeObjects;
- (void)addObject:(id)object withBoundingBox:(CGRect)boundingBox;
- (NSArray *)nodesContainingBoundingBox:(CGRect)boundingBox;
- (NSArray *)retrieveObjectsNear:(CGRect)boundingBox;

@end