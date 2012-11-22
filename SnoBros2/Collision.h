//
//  Collision.h
//  SnoBros2
//
//  Created by Cjab on 11/12/12.
//  Copyright (c) 2012 Cjab. All rights reserved.
//

#include "Component.h"

@class Entity;

@interface Collision : Component {
  float radius_;
}

@property (nonatomic) float radius;

- (id)initWithEntity:(Entity *)entity radius:(float)radius;
- (id)initWithEntity:(Entity *)entity dictionary:(NSDictionary *)data;

- (CGRect)boundingBox;

@end
