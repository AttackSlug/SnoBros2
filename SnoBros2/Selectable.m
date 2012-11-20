//
//  Selectable.m
//  SnoBros2
//
//  Created by Tanoy Sinha on 11/20/12.
//  Copyright (c) 2012 Cjab. All rights reserved.
//

#import "Selectable.h"

@implementation Selectable

@synthesize selected = selected_;

- (id)initWithEntity:(Entity *)entity {
  self = [super initWithEntity:entity];
  if (self) {
    selected_ = FALSE;
  }
  return self;
}

@end
