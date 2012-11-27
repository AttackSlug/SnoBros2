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
@synthesize scale = scale_;

- (id)initWithEntity:(Entity *)entity {
  self = [super initWithEntity:entity];
  if (self) {
    scale_ = GLKVector2Make(1.f, 1.f);
  }
  return self;
}



- (id)initWithEntity:(Entity *)entity dictionary:(NSDictionary *)data {
  self = [self initWithEntity:entity];
  if (self) {
    NSDictionary *p = data[@"Position"];
    position_ = GLKVector2Make([p[@"X"] floatValue],
                               [p[@"Y"] floatValue]);
    previousPosition_ = position_;

    NSDictionary *s = data[@"Scale"];
    if (s) {
      scale_    = GLKVector2Make([s[@"X"] floatValue],
                                 [s[@"Y"] floatValue]);
    }
  }
  return self;
}



- (void)translate:(GLKVector2)translation {
  position_ = GLKVector2Add(position_, translation);
}



- (bool)isCenterInRectangle:(CGRect)rectangle {
  return CGRectContainsPoint(rectangle, CGPointMake(position_.x, position_.y));
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
