//
//  Quadtree.h
//  SnoBros2
//
//  Created by Chad Jablonski on 11/12/12.
//  Copyright (c) 2012 Attack Slug. All rights reserved.
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
- (int)getIndexOfEntity:(Entity *)entity;
- (void)insert:(Entity *)entity;
- (NSMutableArray *)retrieveEntitiesNear:(Entity *)entity;
- (NSArray *)retrieveRectanglesNear:(CGRect)rectangle;

@end