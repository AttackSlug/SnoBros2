//
//  BoundingBox.m
//  SnoBros2
//
//  Created by Cjab on 12/10/12.
//  Copyright (c) 2012 Attack Slug. All rights reserved.
//

#import "BoundingBox.h"

@implementation BoundingBox

- (id)initWithOrigin:(GLKVector2)origin size:(CGSize)size {
  self = [super init];
  if (self) {
    rectangle_ = CGRectMake(origin.x - (size.width / 2.f),
                            origin.y - (size.width / 2.f),
                            size.width,
                            size.height);
  }
  return self;
}



- (id)initWithX:(float)x Y:(float)y width:(float)width height:(float)height {
  GLKVector2 origin = GLKVector2Make(x, y);
  CGSize     size   = CGSizeMake(width, height);
  return [self initWithOrigin:origin size:size];
}



- (float)x {
  return rectangle_.origin.x + (rectangle_.size.width / 2);
}



- (void)setX:(float)x {
  rectangle_.origin.x = x - (rectangle_.size.width  / 2);
}



- (float)y {
  return rectangle_.origin.y + (rectangle_.size.height / 2);
}



- (void)setY:(float)y {
  rectangle_.origin.y = y - (rectangle_.size.height / 2);
}



- (float)width {
  return rectangle_.size.width;
}



- (void)setWidth:(float)width {
  rectangle_.size.width = width;
}



- (float)height {
  return rectangle_.size.height;
}



- (void)setHeight:(float)height {
  rectangle_.size.height = height;
}



- (bool)intersectsWith:(BoundingBox *)other {
  CGRect otherRect = CGRectMake(other.x - (other.width  / 2.f),
                                other.y - (other.height / 2.f),
                                other.width,
                                other.height);
  return CGRectIntersectsRect(rectangle_, otherRect);
}



- (bool)containsPoint:(CGPoint)point {
  return CGRectContainsPoint(rectangle_, point);
}

@end