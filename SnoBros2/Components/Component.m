//
//  Component.m
//  Component
//
//  Created by Chad Jablonski on 11/1/12.
//  Copyright (c) 2012 Attack Slug. All rights reserved.
//

#import "Component.h"
#import "Entity.h"

@implementation Component

- (id)initWithEntity:(Entity *)entity {
  self = [super init];
  if (self) {
    entity_ = entity;
  }
  return self;
}



- (id)initWithEntity:(Entity *)entity dictionary:(NSDictionary *)data {
  return [[Component alloc] initWithEntity:entity];
}



- (void)update {
}

@end