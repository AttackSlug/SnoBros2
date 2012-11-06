//
//  Renderer.h
//  Component
//
//  Created by Cjab on 11/3/12.
//  Copyright (c) 2012 Cjab. All rights reserved.
//

#import <GLKit/GLKit.h>
#import "Component.h"
#import "Transform.h"
#import "Sprite.h"

@interface Renderer : Component {
  GLKBaseEffect  *effect_;
  Sprite         *sprite_;
  Transform      *transform_;
}

- (id)initWithEntity:(Entity *)entity transform:(Transform *)transform;
- (void)update;

@end
