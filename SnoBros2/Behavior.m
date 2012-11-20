//
//  Behavior.m
//  Component
//
//  Created by Cjab on 11/5/12.
//  Copyright (c) 2012 Cjab. All rights reserved.
//

#import "Behavior.h"
#import "Entity.h"
#import "Transform.h"
#import "Physics.h"
#import "EntityManager.h"
#import "Camera.h"
#import "Sprite.h"
#import "Renderer.h"
#import "Game.h"

@implementation Behavior


- (id)initWithEntity:(Entity *)entity
           transform:(Transform *)transform
             physics:(Physics *)physics {
  self = [super initWithEntity:entity];
  if (self) {
    transform_     = transform;
    physics_       = physics;
  }
  return self;
}



- (void)update {
  if (GLKVector2Distance(transform_.position, target_) <= 10) {
    physics_.velocity = GLKVector2Make(0.f, 0.f);
  }
}

@end
