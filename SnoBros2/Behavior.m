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
               scene:(Game *)scene {
  self = [super initWithEntity:entity];
  if (self) {
    transform_     = transform;
    physics_       = physics;
    scene_         = scene;
  }
  return self;
}



- (void)update {
  if (GLKVector2Distance(transform_.position, target_) > 10) {
    physics_.velocity = GLKVector2MultiplyScalar(direction_, 10);
  } else {
    physics_.velocity = GLKVector2Make(0.f, 0.f);
  }
  float xclip = MIN(-(entity_.transform.position.x-scene_.camera.position.x-scene_.camera.viewport.x),
                    entity_.transform.position.x-scene_.camera.position.x);
  float yclip = MIN(-(entity_.transform.position.y-scene_.camera.position.y-scene_.camera.viewport.y),
                    entity_.transform.position.y-scene_.camera.position.y);
  if (xclip < 160 || yclip < 120) {
    GLKVector2 target = GLKVector2Subtract(entity_.transform.position,
                                           GLKVector2Make(scene_.camera.viewport.x/2,
                                                          scene_.camera.viewport.y/2));
    [scene_.camera panCameraWithHeading:GLKVector2Normalize(GLKVector2Subtract(target,
                                                                               scene_.camera.position))];
  }
}

@end
