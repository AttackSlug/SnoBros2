//
//  Transform.m
//  Component
//
//  Created by Chad Jablonski on 11/1/12.
//  Copyright (c) 2012 Attack Slug. All rights reserved.
//

#import "Transform.h"

@implementation Transform

@synthesize position = position_;
@synthesize previousPosition = previousPosition_;

- (id)initWithEntity:(Entity *)entity {
  self = [super initWithEntity:entity];
  if (self) {
  }
  return self;
}



- (id)initWithEntity:(Entity *)entity dictionary:(NSDictionary *)data {
  self = [self initWithEntity:entity];
  if (self) {
    NSDictionary *p = data[@"Position"];
    position_ = GLKVector2Make([p[@"x"] floatValue],
                               [p[@"y"] floatValue]);
    previousPosition_ = position_;
  }
  return self;
}



- (void)translate:(GLKVector2)translation {
  position_ = GLKVector2Add(position_, translation);
}



- (Transform *)copy {
  Transform *copy = [[Transform alloc] initWithEntity:entity_];
  copy.position = position_;
  return copy;
}



- (void)update {
  previousPosition_ = position_;
}

@end