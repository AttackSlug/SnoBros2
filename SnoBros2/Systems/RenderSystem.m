//
//  RenderSystem.m
//  SnoBros2
//
//  Created by Tanoy Sinha on 11/24/12.
//  Copyright (c) 2012 Attack Slug. All rights reserved.
//

#import "RenderSystem.h"

#import "ShaderManager.h"
#import "Entity.h"
#import "EntityManager.h"
#import "Camera.h"
#import "Transform.h"
#import "Sprite.h"
#import "SpriteManager.h"
#import "SceneGraph.h"
#import "SceneNode.h"
#import "Health.h"

@implementation RenderSystem

- (id)initWithEntityManager:(EntityManager *)entityManager
              spriteManager:(SpriteManager *)spriteManager
                     camera:(Camera *)camera {
  self = [super init];
  if (self) {
    entityManager_  = entityManager;
    
    spriteManager_  = spriteManager;
    
    shaderManager_  = [[ShaderManager alloc] init];
    [shaderManager_ loadShadersFromFile:@"shaders"];
    [shaderManager_ loadProgramsFromFile:@"programs"];
    [shaderManager_ useProgramWithName:@"Basic"];
    
    camera_         = camera;
    glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
    glCullFace(GL_FRONT);
    glDepthFunc(GL_LEQUAL);
    
    glEnable(GL_DEPTH_TEST);
    glEnable(GL_BLEND);
    glEnable(GL_CULL_FACE);
  }
  return self;
}



- (void)renderEntitieswithInterpolationRatio:(double)ratio {
  NSMutableArray *entities = entityManager_.entitiesInViewPort;
  for (Entity *e in entities) {
    [self renderEntity:e withInterpolationRatio:ratio];
  }
}



- (void)renderEntity:(Entity *)entity withInterpolationRatio:(double)ratio {
  Transform   *transform  = [entity getComponentByString:@"Transform"];
  SceneGraph  *sceneGraph = [entity getComponentByString:@"SceneGraph"];
  Health      *health     = [entity getComponentByString:@"Health"];

  GLKVector2  scale             = transform.scale;
  GLKVector2  position          = GLKVector2Lerp(transform.previousPosition,
                                                 transform.position,
                                                 ratio);
  GLKMatrix4  translationMatrix = GLKMatrix4MakeTranslation(position.x,
                                                            position.y,
                                                            sceneGraph.layer);
  GLKMatrix4  scaleMatrix       = GLKMatrix4MakeScale(scale.x, scale.y, 1.f);
  GLKMatrix4  modelViewMatrix   = GLKMatrix4Multiply(translationMatrix,
                                                     scaleMatrix);

  if (health != nil) {
    [self transformHealthBar:[sceneGraph getNodeByName:health.spriteName] withHealthComponent:health];
  }

  [sceneGraph updateRootModelViewMatrix:modelViewMatrix];
  [self renderSceneGraph:sceneGraph];
}



- (void)renderSceneGraph:(SceneGraph *)sceneGraph {
  [self renderSceneNode:sceneGraph.rootNode];
}



- (void)renderSceneNode:(SceneNode *)node {
  if (node.visible == FALSE) {
    return;
  }
  Sprite *sprite = [spriteManager_ getSpriteWithRef:node.spriteName];
  NSDictionary *vars = [shaderManager_ getActiveProgramVariables];
  
  GLint texSlot = [[vars objectForKey:@"inputTexCoord"] intValue];
  GLint vertSlot = [[vars objectForKey:@"position"] intValue];
  GLint mvpSlot = [[vars objectForKey:@"modelViewProjection"] intValue];
  
  float left   = camera_.position.x;
  float right  = camera_.viewport.x + camera_.position.x;
  float bottom = camera_.viewport.y + camera_.position.y;
  float top    = camera_.position.y;
  float near   = -16.f;
  float far    =  16.f;
  
  GLKMatrix4 mvpMatrix = GLKMatrix4Multiply(GLKMatrix4MakeOrtho(left,
                                                                right,
                                                                bottom,
                                                                top,
                                                                near,
                                                                far),
                                            node.modelViewMatrix);
  glUniformMatrix4fv(mvpSlot, 1, 0, (const GLfloat *) &mvpMatrix);
  
  glBindTexture(GL_TEXTURE_2D, sprite.texture.name);
  
  glEnableVertexAttribArray(texSlot);
  glVertexAttribPointer(texSlot, 2, GL_FLOAT,
                        GL_FALSE, 0, sprite.uvMap);
  
  glEnableVertexAttribArray(vertSlot);
  glVertexAttribPointer(vertSlot, 2, GL_FLOAT,
                        GL_FALSE, 0, sprite.vertices);
  
  glDrawArrays(GL_TRIANGLE_FAN, 0, 4);
  glDisableVertexAttribArray(vertSlot);
  glDisableVertexAttribArray(texSlot);
  
  if (node.children != nil) {
    for (SceneNode *child in node.children) {
      [self renderSceneNode:child];
    }
  }
}



- (void)transformHealthBar:(SceneNode *)node withHealthComponent:(Health *)health {
  Sprite *parentSprite = [spriteManager_ getSpriteWithRef:node.parent.spriteName];
  float percent = health.health / health.maxHealth;
  float ytrans = -(parentSprite.height/2.f) -5;

  node.modelViewMatrix = GLKMatrix4Multiply(GLKMatrix4MakeScale(percent, 1, 1),
                                                 GLKMatrix4MakeTranslation(0, ytrans, 0));
  node.visible = health.visible;
}

@end
