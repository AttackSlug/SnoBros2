//
//  Team.m
//  SnoBros2
//
//  Created by Chad Jablonski on 11/26/12.
//  Copyright (c) 2012 Attack Slug. All rights reserved.
//

#import "Team.h"

#import "Entity.h"

@implementation Team

@synthesize name = name_;

- (id)initWithEntity:(Entity *)entity {
  self = [super initWithEntity:entity];
  if (self) {
  }
  return self;
}



- (id)initWithEntity:(Entity *)entity dictionary:(NSDictionary *)data {
  self = [self initWithEntity:entity];
  if (self) {
    name_ = data[@"Name"];
  }
  return self;
}

@end