//
//  Renderer.h
//  Component
//
//  Created by Cjab on 11/3/12.
//  Copyright (c) 2012 Cjab. All rights reserved.
//

#import "Component.h"
#import <GLKit/GLKit.h>

@interface Renderer : Component {
  GLKBaseEffect *effect_;
  GLKVector2    vertices_[4];
}

+ (void)setup:(UIResponder *)delegate;

- (id)initWithEntity:(Entity *)entity;
- (void)update;

@end
