//
//  MapGrid.h
//  SnoBros2
//
//  Created by Chad Jablonski on 11/29/12.
//  Copyright (c) 2012 Attack Slug. All rights reserved.
//

#import <GLKit/GLKit.h>
#import <Foundation/Foundation.h>

@class MapNode;
@class BoundingBox;

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
  BoundingBox    *bounds_;
  NSArray        *nodes_;
}

- (id)initWithBounds:(BoundingBox *)bounds nodeSize:(CGSize)nodeSize;

- (MapNode *)findNodeByGridCoordinatesX:(int)x Y:(int)y;
- (MapNode *)findNodeByRealCoordinates:(GLKVector2)realCoordinates;
- (GLKVector2)gridCoordinatesFromRealCoordinates:(GLKVector2)realCoordinates;

@end