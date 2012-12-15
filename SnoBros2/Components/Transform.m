//
//  Transform.m
//  Component
//
//  Created by Chad Jablonski on 11/1/12.
//  Copyright (c) 2012 Attack Slug. All rights reserved.
//

#import "Transform.h"

#import "BoundingBox.h"

@implementation Transform

@synthesize position = position_;
@synthesize previousPosition = previousPosition_;
@synthesize scale = scale_;
@synthesize hasMoved = hasMoved_;

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
    
    hasMoved_ = FALSE;
  }
  return self;
}



- (void)translate:(GLKVector2)translation {
  position_ = GLKVector2Add(position_, translation);
}



- (bool)isCenterInBoundingBox:(BoundingBox *)boundingBox {
  return [boundingBox containsPoint:CGPointMake(position_.x, position_.y)];
}



- (void)update {
  if (fabs(GLKVector2Distance(previousPosition_, position_)) > 0) {
    hasMoved_ = TRUE;
  } else {
    hasMoved_ = FALSE;
  }
  previousPosition_ = position_;
}

@end