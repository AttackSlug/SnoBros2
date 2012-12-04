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


    NSString *collided = [entity.uuid stringByAppendingString:@"|collidedWith"];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(collidedWith:)
                                                 name:collided object:nil];
  }
  return self;
}



- (id)initWithEntity:(Entity *)entity dictionary:(NSDictionary *)data {
  return [self initWithEntity:entity];
}



- (void)collidedWith:(NSNotification *)notification {
  Transform *transform      = [entity_ getComponentByString:@"Transform"];

  Entity *other             = [notification userInfo][@"other"];
  Collision *otherCollision = [other getComponentByString:@"Collision"];

  CGPoint targetPoint = CGPointMake(target_.x, target_.y);
  if (CGRectContainsPoint(otherCollision.boundingBox, targetPoint)) {
    // Dude, stop walking! You can't make it there.
    NSLog(@"STOPPING");
    target_ = transform.position;
  }
}



- (void)walkTo:(NSNotification *)notification {
  [[notification userInfo][@"target"] getValue:&target_];
  [self walkToTarget:target_];
}



- (void)walkToTarget:(GLKVector2)target {
  Transform *transform  = [entity_ getComponentByString:@"Transform"];
  Physics   *physics    = [entity_ getComponentByString:@"Physics"];
  target_ = target;

  direction_ = GLKVector2Normalize(GLKVector2Subtract(target_,
                                                      transform.position));
  physics.velocity = GLKVector2MultiplyScalar(direction_, 10);
}



- (void)update {
  Transform *transform  = [entity_ getComponentByString:@"Transform"];
  Physics   *physics    = [entity_ getComponentByString:@"Physics"];
  float      distance   = GLKVector2Distance(transform.position, target_);

  if ([ASFloat is:distance equalTo:0.f]) {
    physics.velocity = GLKVector2Make(0.f, 0.f);
  } else if ([physics isMovingAwayFrom:target_]) {
    [self walkToTarget:target_];
  }
}

@end