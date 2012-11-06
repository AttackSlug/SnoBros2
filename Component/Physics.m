//
//  Physics.m
//  Component
//
//  Created by Cjab on 11/1/12.
//  Copyright (c) 2012 Cjab. All rights reserved.
//

#import "Entity.h"
#import "Physics.h"
#import "Transform.h"

@implementation Physics


@synthesize velocity = velocity_;


- (id)initWithEntity:(Entity *)entity transform:(Transform *)transform {
  self = [super initWithEntity:entity];
  if (self) {
    transform_ = transform;
  }
  return self;
}



- (void)update {
  [transform_ translate:velocity_];
}

@end