//
//  CreateEntity.m
//  Component
//
//  Created by Cjab on 11/7/12.
//  Copyright (c) 2012 Cjab. All rights reserved.
//

#import "CreateEntity.h"

@implementation CreateEntity

@synthesize entity = entity_;


- (id)initWithEntity:(Entity *)entity {
  self = [super init];
  if (self) {
    entity_ = entity;
  }
  return self;
}


@end
