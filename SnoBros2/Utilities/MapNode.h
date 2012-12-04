//
//  MapNode.h
//  SnoBros2
//
//  Created by Chad Jablonski on 11/29/12.
//  Copyright (c) 2012 Attack Slug. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GLKit/GLKit.h>

@interface MapNode : NSObject {
  MapNode        *parent_;
  NSMutableArray *neighbors_;
  GLKVector2      position_;
  CGSize          size_;
  int             g_;
  int             h_;
  int             f_;
}

@property (nonatomic) MapNode        *parent;
@property (nonatomic) NSMutableArray *neighbors;
@property (nonatomic) GLKVector2      position;
@property (nonatomic) CGSize          size;
@property (nonatomic) int             g;
@property (nonatomic) int             h;
@property (nonatomic) int             f;

- (id)initWithPosition:(GLKVector2)position size:(CGSize)size;
- (float)movementCostTo:(MapNode *)neighbor;
- (NSArray *)findNeighbors;
- (CGRect)boundingBox;

@end