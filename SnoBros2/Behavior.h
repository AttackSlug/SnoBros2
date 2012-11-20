//
//  Behavior.h
//  Component
//
//  Created by Cjab on 11/5/12.
//  Copyright (c) 2012 Cjab. All rights reserved.
//

#import <GLKit/GLKit.h>
#import "Component.h"

@class Transform;
@class Physics;
@class EntityManager;
@class Entity;

@interface Behavior : Component {
  GLKVector2      target_;
  GLKVector2      direction_;
  Transform       *transform_;
  Physics         *physics_;
}

- (id)initWithEntity:(Entity *)entity
           transform:(Transform *)transform
             physics:(Physics *)physics;
- (void)update;

@end
