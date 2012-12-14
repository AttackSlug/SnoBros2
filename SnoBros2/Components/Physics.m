//
//  Physics.m
//  Component
//
//  Created by Chad Jablonski on 11/1/12.
//  Copyright (c) 2012 Attack Slug. All rights reserved.
//

#import "Physics.h"
#import "Transform.h"
#import "Entity.h"
#import "Collision.h"
#import "ASFloat.h"

@implementation Physics

@synthesize velocity = velocity_;

- (id)initWithEntity:(Entity *)entity {
  self = [super initWithEntity:entity];
  if (self) {
  }
  return self;
}



- (id)initWithEntity:(Entity *)entity dictionary:(NSDictionary *)data {
  self = [self initWithEntity:entity];
  if (self) {
    NSDictionary *v = data[@"Velocity"];
    velocity_ = GLKVector2Make([v[@"X"] floatValue],
                               [v[@"Y"] floatValue]);
  }
  return self;
}



- (bool)isMovingAwayFrom:(GLKVector2)target {
  Transform *transform      = [entity_ getComponentByString:@"Transform"];
  GLKVector2 position       = transform.position;
  GLKVector2 futurePosition = GLKVector2Add(position, velocity_);
  float      distance       = GLKVector2Distance(position, target);
  float      futureDistance = GLKVector2Distance(futurePosition, target);

  return FLOAT_GREATER_THAN(futureDistance, distance);
}



- (bool)isMovingTowards:(GLKVector2)target {
  Transform *transform      = [entity_ getComponentByString:@"Transform"];
  GLKVector2 position       = transform.position;
  GLKVector2 futurePosition = GLKVector2Add(position, velocity_);
  float      distance       = GLKVector2Distance(position, target);
  float      futureDistance = GLKVector2Distance(futurePosition, target);

  return FLOAT_LESS_THAN(distance, futureDistance);
}



- (void)update {
  Transform *transform = [entity_ getComponentByString:@"Transform"];
  [transform translate:velocity_];
}

@end