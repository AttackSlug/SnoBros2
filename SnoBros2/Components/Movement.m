//
//  Movement.m
//  SnoBros2
//
//  Created by Chad Jablonski on 12/7/12.
//  Copyright (c) 2012 Attack Slug. All rights reserved.
//

#import "Movement.h"

@implementation Movement

@synthesize target = target_;
@synthesize speed  = speed_;

- (id)initWithEntity:(Entity *)entity {
  self = [super initWithEntity:entity];
  if (self) {
    speed_ = DEFAULT_SPEED;
  }
  return self;
}



- (id)initWithEntity:(Entity *)entity dictionary:(NSDictionary *)data {
  self = [self initWithEntity:entity];
  if (self) {
    speed_ = [data[@"Speed"] intValue];
  }
  return self;
}

@end