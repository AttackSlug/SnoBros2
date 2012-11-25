//
//  Game.h
//  SnoBros2
//
//  Created by Tanoy Sinha on 11/18/12.
//  Copyright (c) 2012 Cjab. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Camera;
@class EntityManager;
@class CollisionSystem;
@class InputSystem;
@class RenderSystem;

const static float TIMESTEP_INTERVAL = 1.f / 60.f;
const static int   MAX_STEPS         = 5;

@interface Game : NSObject {
  EntityManager         *entityManager_;

  Camera                *camera_;
  CollisionSystem       *collisionSystem_;
  InputSystem           *inputSystem_;
  RenderSystem          *renderSystem_;

  NSTimeInterval        timestepAccumulator_;
  NSTimeInterval        timestepAccumulatorRatio_;
  NSTimeInterval const  timestepInterval_;
}

@property (nonatomic) Camera        *camera;
@property (nonatomic) EntityManager *entityManager;

- (void)update:(NSTimeInterval)elapsedTime;
- (void)step;
- (void)render;

@end