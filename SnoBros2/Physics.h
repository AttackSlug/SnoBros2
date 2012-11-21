//
//  Physics.h
//  Component
//
//  Created by Cjab on 11/1/12.
//  Copyright (c) 2012 Cjab. All rights reserved.
//

#import <GLKit/GLKit.h>
#import "Component.h"

@class Entity;

@interface Physics : Component {
  GLKVector2 velocity_;
}

@property GLKVector2 velocity;

- (id)initWithEntity:(Entity *)entity;
- (void)resolveCollisionWith:(Entity *)otherEntity;
- (void)update;

@end