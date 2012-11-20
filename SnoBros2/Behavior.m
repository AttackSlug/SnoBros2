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
             physics:(Physics *)physics
              camera:(Camera *)camera {
  self = [super initWithEntity:entity];
  if (self) {
    transform_     = transform;
    physics_       = physics;
    camera_        = camera;
  }
  return self;
}



- (void)update {
  if (GLKVector2Distance(transform_.position, target_) > 10) {
    physics_.velocity = GLKVector2MultiplyScalar(direction_, 10);
  } else {
    physics_.velocity = GLKVector2Make(0.f, 0.f);
  }
  float xclip = MIN(-(entity_.transform.position.x-camera_.position.x-camera_.viewport.x),
                    entity_.transform.position.x-camera_.position.x);
  float yclip = MIN(-(entity_.transform.position.y-camera_.position.y-camera_.viewport.y),
                    entity_.transform.position.y-camera_.position.y);
  if (xclip < 160 || yclip < 120) {
    GLKVector2 target = GLKVector2Subtract(entity_.transform.position,
                                           GLKVector2Make(camera_.viewport.x/2,
                                                          camera_.viewport.y/2));
    [camera_ panCameraWithHeading:GLKVector2Normalize(GLKVector2Subtract(target,
                                                                               camera_.position))];
  }
}

@end
