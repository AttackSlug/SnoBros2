//
//  RenderSystem.m
//  SnoBros2
//
//  Created by Tanoy Sinha on 11/24/12.
//  Copyright (c) 2012 Cjab. All rights reserved.
//

#import "RenderSystem.h"

#import "Entity.h"
#import "EntityManager.h"
#import "Camera.h"

@implementation RenderSystem

- (id)initWithEntityManager:(EntityManager *)entityManager camera:(Camera *)camera {
  self = [super init];
  if (self) {
    entityManager_  = entityManager;
    camera_         = camera;
  }
  return self;
}



- (void)renderEntities {
  for (Entity *e in [entityManager_ allEntities]) {
    
  }
}



- (void)renderEntity:(Entity *)entity withCamera:(Camera *)camera {
  
}

@end
