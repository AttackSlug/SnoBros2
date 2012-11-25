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

@implementation LeftPlayer

- (id)initWithEntity:(Entity *)entity {
  self = [super initWithEntity:entity];
  if (self) {
    NSString *walkTo = [@"walkTo:" stringByAppendingString:entity_.uuid];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(walkTo:)
                                                 name:walkTo
                                               object:nil];
  }
  return self;
}



- (id)initWithEntity:(Entity *)entity dictionary:(NSDictionary *)data {
  return [self initWithEntity:entity];
}



- (void)walkTo:(NSNotification *)notification {
  Transform *transform  = [entity_ getComponentByString:@"Transform"];
  Physics   *physics    = [entity_ getComponentByString:@"Physics"];

  [[notification userInfo][@"target"] getValue:&target_];

  direction_ = GLKVector2Normalize(GLKVector2Subtract(target_,
                                                      transform.position));
  physics.velocity = GLKVector2MultiplyScalar(direction_, 10);
}

@end