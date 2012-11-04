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



- (void)update {
  [effect_ prepareToDraw];
  
  //glEnableVertexAttribArray(GLKVertexAttribTexCoord0);
  //glVertexAttribPointer(GLKVertexAttribTexCoord0, 2, GL_FLOAT,
  //                      GL_FALSE, 0, textureCoords_);
  
  
  glEnableVertexAttribArray(GLKVertexAttribPosition);
  glVertexAttribPointer(GLKVertexAttribPosition, 2, GL_FLOAT,
                        GL_FALSE, 0, vertices_);
  
  glDrawArrays(GL_TRIANGLE_FAN, 0, 4);
  glDisableVertexAttribArray(GLKVertexAttribPosition);
  glDisableVertexAttribArray(GLKVertexAttribTexCoord0);
}


@end