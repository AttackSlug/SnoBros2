//
//  Transform.m
//  Component
//
//  Created by Cjab on 11/1/12.
//  Copyright (c) 2012 Cjab. All rights reserved.
//

#import "Transform.h"

@implementation Transform


- (id)initWithEntity:(Entity *)entity {
  return [super initWithEntity:entity];
}



- (void)translate:(GLKVector2)translation {
  position_ = GLKVector2Add(position_, translation);
}


@end