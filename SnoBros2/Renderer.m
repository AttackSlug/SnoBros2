//
//  Renderer.m
//  Component
//
//  Created by Cjab on 11/3/12.
//  Copyright (c) 2012 Cjab. All rights reserved.
//

#import "Renderer.h"
#import "Transform.h"
#import "Sprite.h"
#import "Camera.h"
#import "Entity.h"

@implementation Renderer

@synthesize width  = width_;
@synthesize height = height_;
@synthesize layer  = layer_;


- (id)initWithEntity:(Entity *)entity
           transform:(Transform *)transform
              sprite:(Sprite *)sprite
               layer:(int)layer {
  self = [super initWithEntity:entity];
  if (self) {
    transform_          = transform;
    previousTransform_  = [transform_ copy];
    sprite_             = sprite;
    effect_             = [[GLKBaseEffect alloc] init];
    layer_              = layer;

    width_  = 480;
    height_ = 320;
  }
  return self;
}



- (void)update {
  previousTransform_ = [transform_ copy];
}



- (void)renderWithCamera:(Camera*)camera interpolationRatio:(double)ratio {
  effect_.texture2d0.envMode = GLKTextureEnvModeReplace;
  effect_.texture2d0.target  = GLKTextureTarget2D;
  effect_.texture2d0.name    = sprite_.texture.name;

  GLKVector2 position  = GLKVector2Lerp(previousTransform_.position,
                                        transform_.position,
                                        ratio);
  float left   = camera.position.x;
  float right  = camera.viewport.x + camera.position.x;
  float bottom = camera.viewport.y + camera.position.y;
  float top    = camera.position.y;
  float near   = -16.f;
  float far    = 16.f;

  effect_.transform.projectionMatrix =
    GLKMatrix4MakeOrtho(left, right, bottom, top, near, far);
  effect_.transform.modelviewMatrix =
    GLKMatrix4MakeTranslation(position.x, position.y, layer_);

  [effect_ prepareToDraw];

  glEnableVertexAttribArray(GLKVertexAttribTexCoord0);
  glVertexAttribPointer(GLKVertexAttribTexCoord0, 2, GL_FLOAT,
                        GL_FALSE, 0, sprite_.uvMap);

  glEnableVertexAttribArray(GLKVertexAttribPosition);
  glVertexAttribPointer(GLKVertexAttribPosition, 2, GL_FLOAT,
                        GL_FALSE, 0, sprite_.vertices);

  glDrawArrays(GL_TRIANGLE_FAN, 0, 4);
  glDisableVertexAttribArray(GLKVertexAttribPosition);
  glDisableVertexAttribArray(GLKVertexAttribTexCoord0);
}


@end