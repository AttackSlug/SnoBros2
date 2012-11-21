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
#import "Event.h"

@implementation LeftPlayer

- (id)initWithEntity:(Entity *)entity {
  return [super initWithEntity:entity];
}



- (void)walkTo:(GLKVector2)target {
  target_    = target;
  direction_ = GLKVector2Normalize(GLKVector2Subtract(target_,
                                                      entity_.transform.position));
  entity_.physics.velocity = GLKVector2MultiplyScalar(direction_, 10);
}



- (void)receiveEvent:(Event *)event {
  if ([event.type isEqualToString:@"walkTo"]) {

    GLKVector2 target;
    [event.payload getValue:&target];
    [self walkTo:target];

  }
}

@end
