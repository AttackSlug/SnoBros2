//
//  RenderSystem.m
//  SnoBros2
//
//  Created by Tanoy Sinha on 11/24/12.
//  Copyright (c) 2012 Cjab. All rights reserved.
//

#import "RenderSystem.h"

#import "Entity.h"
#import "EntityManager.h"
#import "Camera.h"
#import "Transform.h"
#import "Sprite.h"
#import "Renderable.h"

@implementation RenderSystem

- (id)initWithEntityManager:(EntityManager *)entityManager camera:(Camera *)camera {
  self = [super init];
  if (self) {
    entityManager_  = entityManager;
    camera_         = camera;
  }
  return self;
}



- (void)renderEntitieswithInterpolationRatio:(double)ratio {
  for (Entity *e in [entityManager_ allSortedByLayer]) {
    [self renderEntity:e withInterpolationRatio:ratio];
  }
}



- (void)renderEntity:(Entity *)entity withInterpolationRatio:(double)ratio {
  Transform   *transform  = [entity getComponentByString:@"Transform"];
  Renderable  *renderable = [entity getComponentByString:@"Renderable"];
  GLKVector2  position    = GLKVector2Lerp(transform.previousPosition,
                                           transform.position,
                                           ratio);
  [self renderSprite:renderable.root atPosition:position];
}



- (void)renderSprite:(Sprite *)sprite atPosition:(GLKVector2)position {
  if (sprite.visible == FALSE) {
    return;
  }
  if (sprite.children != nil) {
    for (Sprite *child in sprite.children) {
      [self renderSprite:child atPosition:position];
    }
  }
  GLKBaseEffect *effect = [[GLKBaseEffect alloc] init];
  
  effect.texture2d0.envMode = GLKTextureEnvModeReplace;
  effect.texture2d0.target  = GLKTextureTarget2D;
  effect.texture2d0.name    = sprite.texture.name;
  
  float left   = camera_.position.x;
  float right  = camera_.viewport.x + camera_.position.x;
  float bottom = camera_.viewport.y + camera_.position.y;
  float top    = camera_.position.y;
  float near   = -16.f;
  float far    =  16.f;
  
  effect.transform.projectionMatrix = GLKMatrix4MakeOrtho(left, right, bottom, top, near, far);
  effect.transform.modelviewMatrix = GLKMatrix4Multiply(sprite.modelViewMatrix,
                                                        GLKMatrix4MakeTranslation(position.x,
                                                                                  position.y,
                                                                                  sprite.layer));
  
  [effect prepareToDraw];
  
  glEnableVertexAttribArray(GLKVertexAttribTexCoord0);
  glVertexAttribPointer(GLKVertexAttribTexCoord0, 2, GL_FLOAT,
                        GL_FALSE, 0, sprite.uvMap);
  
  glEnableVertexAttribArray(GLKVertexAttribPosition);
  glVertexAttribPointer(GLKVertexAttribPosition, 2, GL_FLOAT,
                        GL_FALSE, 0, sprite.vertices);
  
  glDrawArrays(GL_TRIANGLE_FAN, 0, 4);
  glDisableVertexAttribArray(GLKVertexAttribPosition);
  glDisableVertexAttribArray(GLKVertexAttribTexCoord0);
}

@end
