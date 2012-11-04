//
//  Physics.h
//  Component
//
//  Created by Cjab on 11/1/12.
//  Copyright (c) 2012 Cjab. All rights reserved.
//

#import "Component.h"
#import <GLKit/GLKit.h>

@interface Physics : Component {
  GLKVector2 velocity_;
}

- (id)initWithEntity:(Entity *)entity;
- (void)update;

@end