//
//  MapNode.m
//  SnoBros2
//
//  Created by Chad Jablonski on 11/29/12.
//  Copyright (c) 2012 Attack Slug. All rights reserved.
//

#import "MapNode.h"

#import "Entity.h"
#import "Transform.h"

@implementation MapNode

@synthesize parent    = parent_;
@synthesize neighbors = neighbors_;
@synthesize position  = position_;
@synthesize size      = size_;
@synthesize g         = g_;
@synthesize h         = h_;
@synthesize f         = f_;

- (id)initWithPosition:(GLKVector2)position size:(CGSize)size {
self = [super init];
  if (self) {
    neighbors_ = [[NSMutableArray alloc] init];
    position_  = position;
    size_      = size;

    int _DEBUG = 0;

    if (_DEBUG) {
      [self display];
    }
  }
  return self;
}



- (float)movementCostTo:(MapNode *)neighbor {
  return GLKVector2Distance(position_, neighbor.position);
}



- (NSArray *)findNeighbors {
  NSMutableArray *neighborsFound = [[NSMutableArray alloc] init];

  for (MapNode *node in neighbors_) {
    if (node) {
      [neighborsFound addObject:node];
    }
  }

  return neighborsFound;
}



- (CGRect)boundingBox {
  return CGRectMake(position_.x, position_.y, size_.width, size_.height);
}



- (void)display {
  void (^callback)(Entity *) = ^(Entity *entity){
    Transform  *transform = [entity getComponentByString:@"Transform"];
    transform.position = position_;
    entity_ = entity;
  };

  NSDictionary *data = @{@"type": @"MapNode", @"callback": callback};

  [[NSNotificationCenter defaultCenter] postNotificationName:@"createEntity"
                                                      object:self
                                                    userInfo:data];
}



- (void)hide {
  if (entity_) {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"destroyEntity"
                                                        object:self
                                                      userInfo:@{@"entity": entity_}];
    entity_ = nil;
  }
}

@end
