//
//  Entity.m
//  Component
//
//  Created by Cjab on 11/1/12.
//  Copyright (c) 2012 Cjab. All rights reserved.
//

#import "Entity.h"

@implementation Entity


@synthesize transform = transform_;
@synthesize renderer  = renderer_;
@synthesize physics   = physics_;
@synthesize sprite    = sprite_;
@synthesize input     = input_;
@synthesize ai        = ai_;


- (id)init {
  self = [super init];
  if (self) {
  }
  return self;
}



- (void)update {
  [ai_      update];
  [physics_ update];
}



- (void)render {
  [renderer_ update];
}


@end