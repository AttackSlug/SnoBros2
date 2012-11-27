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

@interface RenderSystem : NSObject {
  EntityManager *entityManager_;
  Camera        *camera_;
}

- (id)initWithEntityManager:(EntityManager *)entityManager camera:(Camera *)camera;

- (void)renderEntitieswithInterpolationRatio:(double)ratio;
- (void)renderEntity:(Entity *)entity withInterpolationRatio:(double)ratio;
- (void)renderSprite:(Sprite *)sprite withModelViewMatrix:(GLKMatrix4)modelViewMatrix;

@end