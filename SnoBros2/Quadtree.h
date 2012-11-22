//
//  Quadtree.h
//  SnoBros2
//
//  Created by Cjab on 11/12/12.
//  Copyright (c) 2012 Cjab. All rights reserved.
//

#import <Foundation/Foundation.h>

#define NUM_NODES 4

@class Entity;

@interface Quadtree : NSObject {
  int maxObjects_;
  int maxLevels_;
  int level_;
  NSMutableArray *entities_;
  CGRect bounds_;
  CGRect topLeft_;
  CGRect topRight_;
  CGRect bottomLeft_;
  CGRect bottomRight_;
  Quadtree *nodes_[NUM_NODES];
}

- (id)initWithLevel:(int)level bounds:(CGRect)bounds;
- (void)subdivideRectangle;
- (void)clear;
- (void)split;
- (int)getIndexOf:(Entity *)entity;
- (void)insert:(Entity *)entity;
- (NSMutableArray *)retrieve:(Entity *)entity;

@end