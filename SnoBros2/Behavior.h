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
@class Game;
@class Camera;

@interface Behavior : Component {
  GLKVector2      target_;
  GLKVector2      direction_;
  Transform       *transform_;
  Physics         *physics_;
  Camera          *camera_;
}

- (id)initWithEntity:(Entity *)entity
           transform:(Transform *)transform
             physics:(Physics *)physics
              camera:(Camera *)camera;
- (void)update;

@end
