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


- (id)initWithEntity:(Entity *)entity
           transform:(Transform *)transform
              sprite:(Sprite *)sprite {
  self = [super initWithEntity:entity];
  if (self) {
    transform_ = transform;
    sprite_    = sprite;
    effect_    = [[GLKBaseEffect alloc] init];

    width_  = 480;
    height_ = 320;
  }
  return self;
}



- (void)updateWithCamera:(Camera*)camera interpolationRatio:(double)ratio {
  glEnable(GL_BLEND);
  glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);

  effect_.texture2d0.envMode = GLKTextureEnvModeReplace;
  effect_.texture2d0.target  = GLKTextureTarget2D;
  effect_.texture2d0.name    = sprite_.texture.name;

  GLKVector2 position  = [transform_ interpolateWithRatio:ratio];
  effect_.transform.modelviewMatrix =
    GLKMatrix4MakeTranslation(position.x, position.y, 0.f);
  
  effect_.transform.projectionMatrix = GLKMatrix4MakeOrtho(camera.position.x,
                                                           camera.viewport.x + camera.position.x,
                                                           camera.viewport.y + camera.position.y,
                                                           camera.position.y,
                                                           -1,
                                                           1);

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