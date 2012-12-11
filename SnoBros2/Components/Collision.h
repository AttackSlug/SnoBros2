//
//  Collision.h
//  SnoBros2
//
//  Created by Chad Jablonski on 11/12/12.
//  Copyright (c) 2012 Attack Slug. All rights reserved.
//

#include "Component.h"

@class Entity;
@class BoundingBox;

@interface Collision : Component {
  float radius_;
}

@property (nonatomic)           float        radius;
@property (nonatomic, readonly) BoundingBox *boundingBox;

- (id)initWithEntity:(Entity *)entity radius:(float)radius;
- (id)initWithEntity:(Entity *)entity dictionary:(NSDictionary *)data;

@end