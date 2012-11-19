//
//  Physics.h
//  Component
//
//  Created by Cjab on 11/1/12.
//  Copyright (c) 2012 Cjab. All rights reserved.
//

#import <GLKit/GLKit.h>
#import "Component.h"

@class Transform;
@class Entity;

@interface Physics : Component {
  GLKVector2 velocity_;
  Transform  *transform_;
}

@property GLKVector2 velocity;

- (id)initWithEntity:(Entity *)entity transform:(Transform *)transform;
- (void)resolveCollisionWith:(Entity *)otherEntity
                intersection:(GLKVector2)intersection;
- (void)update;

@end