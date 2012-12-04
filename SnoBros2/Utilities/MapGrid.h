//
//  MapGrid.h
//  SnoBros2
//
//  Created by Chad Jablonski on 11/29/12.
//  Copyright (c) 2012 Attack Slug. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MapNode;

typedef enum {
  TOP_LEFT,
  LEFT,
  BOTTOM_LEFT,
  BOTTOM,
  BOTTOM_RIGHT,
  RIGHT,
  TOP_RIGHT,
  TOP
} Neighbor;

@interface MapGrid : NSObject {
  CGSize          nodeSize_;
  CGRect          bounds_;
  NSMutableArray *nodes_;
}

- (id)initWithBounds:(CGRect)bounds nodeSize:(CGSize)nodeSize;
- (MapNode *)findNodeByX:(float)x Y:(float)y;

@end