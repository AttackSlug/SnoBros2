//
//  Physics.h
//  Component
//
//  Created by Cjab on 11/1/12.
//  Copyright (c) 2012 Cjab. All rights reserved.
//

#import <GLKit/GLKit.h>
#import "Component.h"
#import "Transform.h"

@interface Physics : Component {
  GLKVector2 velocity_;
  Transform  *transform_;
}

@property GLKVector2 velocity;

- (id)initWithEntity:(Entity *)entity transform:(Transform *)transform;
- (void)update;

@end