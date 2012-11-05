//
//  Renderer.m
//  Component
//
//  Created by Cjab on 11/3/12.
//  Copyright (c) 2012 Cjab. All rights reserved.
//

#import "Renderer.h"

@implementation Renderer


+ (void)setup:(UIResponder *)delegate {
  EAGLContext *context = [[EAGLContext alloc]
                          initWithAPI:kEAGLRenderingAPIOpenGLES2];
  [EAGLContext setCurrentContext:context];
  glEnable(GL_DEPTH_TEST);
}



- (id)initWithEntity:(Entity *)entity {
  self = [super initWithEntity:entity];
  if (self) {
    effect_ = [[GLKBaseEffect alloc] init];
    effect_.transform.projectionMatrix =
      GLKMatrix4MakeOrtho(0, 480, 320, 0, -1, 1);
    
    texture_  = [GLKTextureLoader
                textureWithCGImage:[UIImage imageNamed:@"player.png"].CGImage
                options:nil
                error:nil];
    
    [self calculateVertices:GLKVector2Make(0.f, 0.f)
                   withSize:CGSizeMake(76, 92)];
    [self calculateTexture];
  }
  return self;
}



- (void)calculateVertices:(GLKVector2)position withSize:(CGSize)size {
  vertices_[0] = GLKVector2Make(position.x,
                                position.y + size.height);
  vertices_[1] = GLKVector2Make(position.x,
                                position.y);
  vertices_[2] = GLKVector2Make(position.x + size.width,
                                position.y);
  vertices_[3] = GLKVector2Make(position.x + size.width,
                                position.y + size.height);
}



- (void) calculateTexture {
  uvMap_[0] = GLKVector2Make(0, 1); // ?
  uvMap_[1] = GLKVector2Make(0, 0); // bottom left
  uvMap_[2] = GLKVector2Make(1, 0); // ?
  uvMap_[3] = GLKVector2Make(1, 1); // top right
}



- (void)update {
  effect_.texture2d0.envMode = GLKTextureEnvModeReplace;
  effect_.texture2d0.target  = GLKTextureTarget2D;
  effect_.texture2d0.name    = texture_.name;
  
  [effect_ prepareToDraw];
  
  glEnableVertexAttribArray(GLKVertexAttribTexCoord0);
  glVertexAttribPointer(GLKVertexAttribTexCoord0, 2, GL_FLOAT,
                        GL_FALSE, 0, uvMap_);
  
  glEnableVertexAttribArray(GLKVertexAttribPosition);
  glVertexAttribPointer(GLKVertexAttribPosition, 2, GL_FLOAT,
                        GL_FALSE, 0, vertices_);
  
  glDrawArrays(GL_TRIANGLE_FAN, 0, 4);
  glDisableVertexAttribArray(GLKVertexAttribPosition);
  glDisableVertexAttribArray(GLKVertexAttribTexCoord0);
}


@end