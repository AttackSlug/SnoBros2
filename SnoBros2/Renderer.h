//
//  Renderer.h
//  Component
//
//  Created by Cjab on 11/3/12.
//  Copyright (c) 2012 Cjab. All rights reserved.
//

#import <GLKit/GLKit.h>
#import "Component.h"

@class Transform;
@class Sprite;
@class Camera;
@class Entity;

@interface Renderer : Component {
  GLKBaseEffect  *effect_;
  Sprite         *sprite_;
  Transform      *transform_;
  Transform      *previousTransform_;
  int            width_;
  int            height_;
  int            layer_;
}

@property (readonly, nonatomic) int width;
@property (readonly, nonatomic) int height;
@property (nonatomic)           int layer;

- (id)initWithEntity:(Entity *)entity
           transform:(Transform *)transform
              sprite:(Sprite *)sprite
               layer:(int)layer;
- (void)renderWithCamera:(Camera*)camera
      interpolationRatio:(double)ratio;

@end