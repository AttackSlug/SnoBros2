//
//  Transform.m
//  Component
//
//  Created by Cjab on 11/1/12.
//  Copyright (c) 2012 Cjab. All rights reserved.
//

#import "Transform.h"

@implementation Transform

@synthesize position         = position_;
@synthesize previousPosition = previousPosition_;


- (id)initWithEntity:(Entity *)entity {
  return [super initWithEntity:entity];
}



- (void)position:(GLKVector2)position {
  previousPosition_ = position_;
  position_         = position;
}



- (void)translate:(GLKVector2)translation {
  previousPosition_ = position_;
  position_         = GLKVector2Add(position_, translation);
}



- (GLKVector2)interpolateWithRatio:(double)ratio {
  return GLKVector2Lerp(previousPosition_, position_, ratio);
}


@end