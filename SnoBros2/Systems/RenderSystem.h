//
//  RenderSystem.h
//  SnoBros2
//
//  Created by Tanoy Sinha on 11/24/12.
//  Copyright (c) 2012 Attack Slug. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GLKit/GLKit.h>

@class EntityManager;
@class Entity;
@class Camera;
@class Sprite;
@class SpriteManager;
@class SceneGraph;
@class SceneNode;
@class Health;

@interface RenderSystem : NSObject {
  EntityManager *entityManager_;
  SpriteManager *spriteManager_;
  Camera        *camera_;
}

- (id)initWithEntityManager:(EntityManager *)entityManager camera:(Camera *)camera;

- (void)renderEntitieswithInterpolationRatio:(double)ratio;
- (void)renderEntity:(Entity *)entity withInterpolationRatio:(double)ratio;
- (void)renderSprite:(Sprite *)sprite withModelViewMatrix:(GLKMatrix4)modelViewMatrix;
- (void)renderSceneGraph:(SceneGraph *)sceneGraph;
- (void)renderSceneNode:(SceneNode *)sceneNode;

- (void)transformHealthBar:(SceneNode *)sceneNode withHealthComponent:(Health *)health;

- (GLKBaseEffect *)generateBaseEffectWithSceneNode:(SceneNode *)sceneNode;
- (void)drawSprite:(Sprite *)sprite;

@end