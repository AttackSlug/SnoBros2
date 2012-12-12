//
//  SceneSystem.h
//  SnoBros2
//
//  Created by Tanoy Sinha on 12/12/12.
//  Copyright (c) 2012 Attack Slug. All rights reserved.
//

#import <Foundation/Foundation.h>

@class EntityManager;
@class SpriteManager;
@class Camera;

@interface SceneSystem : NSObject {
  EntityManager *entityManager_;
  SpriteManager *spriteManager_;
  Camera        *camera_;
}

- (id)initWithEntityManager:(EntityManager *)entityManager
              spriteManager:(SpriteManager *)spriteManager
                     camera:(Camera *)camera;
- (void)update;
- (void)updateViewableEntities;

@end
