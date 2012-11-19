//
//  LeftPlayer.m
//  Component
//
//  Created by Cjab on 11/7/12.
//  Copyright (c) 2012 Cjab. All rights reserved.
//

#import "LeftPlayer.h"
#import "Physics.h"
#import "Transform.h"
#import "EntityManager.h"
#import "Entity.h"
#import "ViewController.h"
#import "Camera.h"
#import "EventQueue.h"

@implementation LeftPlayer


- (id)initWithEntity:(Entity *)entity
           transform:(Transform *)transform
             physics:(Physics *)physics
               scene:(EventQueue *)scene
       entityManager:(EntityManager *)entityManager {
  return [super initWithEntity:entity
                     transform:transform
                       physics:physics
                         scene:scene
                 entityManager:entityManager];
}



- (void)walkTo:(NSValue*)message {
  GLKVector2 target;
  [message getValue:&target];
  target_    = GLKVector2Add(scene_.camera.position, target);
  direction_ = GLKVector2Normalize(GLKVector2Subtract(target_, transform_.position));
}

@end