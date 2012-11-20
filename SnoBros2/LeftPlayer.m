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
#import "Entity.h"
#import "Camera.h"
#import "Game.h"

@implementation LeftPlayer


- (id)initWithEntity:(Entity *)entity
           transform:(Transform *)transform
             physics:(Physics *)physics
              camera:(Camera *)camera {
  return [super initWithEntity:entity
                     transform:transform
                       physics:physics
                        camera:camera];
}



- (void)walkTo:(NSValue*)message {
  GLKVector2 target;
  [message getValue:&target];
  target_    = GLKVector2Add(camera_.position, target);
  direction_ = GLKVector2Normalize(GLKVector2Subtract(target_, transform_.position));
}

@end