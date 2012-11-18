//
//  Transform.m
//  Component
//
//  Created by Cjab on 11/1/12.
//  Copyright (c) 2012 Cjab. All rights reserved.
//

#import "Transform.h"

@implementation Transform

@synthesize position = position_;

- (id)initWithEntity:(Entity *)entity {
  self = [super initWithEntity:entity];
  if (self) {
  }
  return self;
}



- (id)initWithEntity:(Entity *)entity dictionary:(NSDictionary *)data {
  self = [self initWithEntity:entity];
  if (self) {
    NSDictionary *p = [data valueForKey:@"position"];
    position_ = GLKVector2Make([[p valueForKey:@"x"] floatValue],
                               [[p valueForKey:@"y"] floatValue]);
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

@end