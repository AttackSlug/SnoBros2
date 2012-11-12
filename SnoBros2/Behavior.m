//
//  Behavior.m
//  Component
//
//  Created by Cjab on 11/5/12.
//  Copyright (c) 2012 Cjab. All rights reserved.
//

#import "Entity.h"
#import "Behavior.h"
#import "Scene.h"
#import "Projectile.h"

@implementation Behavior


- (id)initWithEntity:(Entity *)entity
           transform:(Transform *)transform
             physics:(Physics *)physics
               scene:(Scene *)scene {
  self = [super initWithEntity:entity];
  if (self) {
    transform_ = transform;
    physics_   = physics;
    scene_     = scene;
  }
  return self;
}



- (void)update {
  if (GLKVector2Distance(transform_.position, target_) > 10) {
    physics_.velocity = GLKVector2MultiplyScalar(direction_, 10);
  } else {
    physics_.velocity = GLKVector2Make(0.f, 0.f);
  }
}



- (void)walkTo:(GLKVector2)target {
  GLKVector2 position = transform_.position;
  target_    = target;
  direction_ = GLKVector2Normalize(GLKVector2Subtract(target_, position));
}



- (void)throwAt:(GLKVector2)target {
  GLKVector2 position = transform_.position;
  Entity *snowball = [self createSnowball];
  snowball.transform.position = position;
  [snowball.behavior walkTo:target];
  [scene_ addEntity:snowball];
}



- (Entity *)createSnowball {
  Entity *snowball = [[Entity alloc] init];
  snowball.transform = [[Transform alloc] initWithEntity:snowball];
  snowball.sprite    = [[Sprite alloc]    initWithFile:@"snowball.png"];
  snowball.physics   = [[Physics alloc]   initWithEntity:snowball
                                               transform:snowball.transform];
  snowball.renderer  = [[Renderer alloc]  initWithEntity:snowball
                                               transform:snowball.transform
                                                  sprite:snowball.sprite];
  snowball.behavior  = [[Projectile alloc] initWithEntity:snowball
                                                transform:snowball.transform
                                                  physics:snowball.physics
                                                    scene:scene_];
  return snowball;
}


@end