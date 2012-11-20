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
#import "Game.h"

@implementation LeftPlayer

- (id)initWithEntity:(Entity *)entity
           transform:(Transform *)transform
             physics:(Physics *)physics {
  return [super initWithEntity:entity
                     transform:transform
                       physics:physics];
}



- (void)walkTo:(NSValue*)message {
  GLKVector2 target;
  [message getValue:&target];
  target_    = target;
  direction_ = GLKVector2Normalize(GLKVector2Subtract(target_, transform_.position));
  physics_.velocity = GLKVector2MultiplyScalar(direction_, 10);
}

@end