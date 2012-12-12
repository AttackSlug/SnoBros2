//
//  Game.h
//  SnoBros2
//
//  Created by Tanoy Sinha on 11/18/12.
//  Copyright (c) 2012 Attack Slug. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Camera;
@class EntityManager;
@class SpriteManager;
@class CollisionSystem;
@class InputSystem;
@class RenderSystem;
@class SelectionSystem;
@class PathfindingSystem;
@class MovementSystem;
@class EnemyBehaviorSystem;
@class ProjectileSystem;

const static float TIMESTEP_INTERVAL = 1.f / 60.f;
const static int   MAX_STEPS         = 5;

@interface Game : NSObject {
  EntityManager         *entityManager_;
  SpriteManager         *spriteManager_;

  Camera                *camera_;
  CollisionSystem       *collisionSystem_;
  InputSystem           *inputSystem_;
  RenderSystem          *renderSystem_;
  SelectionSystem       *selectionSystem_;
  PathfindingSystem     *pathfindingSystem_;
  MovementSystem        *movementSystem_;
  EnemyBehaviorSystem   *enemyBehaviorSystem_;
  ProjectileSystem      *projectileSystem_;

  NSTimeInterval        timestepAccumulator_;
  NSTimeInterval        timestepAccumulatorRatio_;
  NSTimeInterval const  timestepInterval_;
}

@property (nonatomic) Camera          *camera;
@property (nonatomic) EntityManager   *entityManager;
@property (nonatomic) SelectionSystem *selectionSystem;

- (void)update:(NSTimeInterval)elapsedTime;
- (void)step;
- (void)render;
- (void)loadMapFromFile:(NSString *)fileName;

@end