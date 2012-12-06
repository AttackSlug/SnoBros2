//
//  LeftPlayer.m
//  Component
//
//  Created by Chad Jablonski on 11/7/12.
//  Copyright (c) 2012 Attack Slug. All rights reserved.
//

#import "LeftPlayer.h"

#import "Entity.h"
#import "Physics.h"
#import "Transform.h"
#import "Collision.h"

#import "ASFloat.h"

@implementation LeftPlayer

- (id)initWithEntity:(Entity *)entity {
  self = [super initWithEntity:entity];
  if (self) {
    NSString *walkTo = [entity_.uuid stringByAppendingString:@"|walkTo"];
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
  [[notification userInfo][@"target"] getValue:&target_];
  [self walkToTarget:target_];
}



- (void)walkToTarget:(GLKVector2)target {
  Transform *transform  = [entity_ getComponentByString:@"Transform"];
  Physics   *physics    = [entity_ getComponentByString:@"Physics"];
  target_ = target;

  GLKVector2 path  = GLKVector2Subtract(target_, transform.position);

  if (GLKVector2Length(path) == 0) {
    direction_ = GLKVector2Make(0.f, 0.f);
  } else {
    direction_ = GLKVector2Normalize(path);
  }

  physics.velocity = GLKVector2MultiplyScalar(direction_, 4);
}



- (void)update {
  Transform *transform  = [entity_ getComponentByString:@"Transform"];
  Physics   *physics    = [entity_ getComponentByString:@"Physics"];
  float      distance   = GLKVector2Distance(transform.position, target_);

  if ([ASFloat is:distance lessThan:4.f]) {
    physics.velocity = GLKVector2Make(0.f, 0.f);
    target_ = transform.position;
  } else if ([physics isMovingAwayFrom:target_]) {
    [self walkToTarget:target_];
  }
}

@end