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

- (id)initWithEntity:(Entity *)entity {
  return [super initWithEntity:entity];
}



- (void)update {
  if (GLKVector2Distance(entity_.transform.position, target_) <= 10) {
    entity_.physics.velocity = GLKVector2Make(0.f, 0.f);
  }
}

@end