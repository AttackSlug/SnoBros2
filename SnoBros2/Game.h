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
@class UIManager;
@class CollisionSystem;
@class InputSystem;
@class RenderSystem;
@class SelectionSystem;
@class PathfindingSystem;
@class MovementSystem;
@class EnemyBehaviorSystem;
@class ProjectileSystem;
@class DamageSystem;
@class GameStateSystem;
@class InputSystem;
@class UISystem;

const static float TIMESTEP_INTERVAL = 1.f / 60.f;
const static int   MAX_STEPS         = 5;

@interface Game : NSObject {
  EntityManager         *entityManager_;
  SpriteManager         *spriteManager_;
  UIManager             *UIManager_;

  Camera                *camera_;
  CollisionSystem       *collisionSystem_;
  InputSystem           *inputSystem_;
  RenderSystem          *renderSystem_;
  SelectionSystem       *selectionSystem_;
  PathfindingSystem     *pathfindingSystem_;
  MovementSystem        *movementSystem_;
  EnemyBehaviorSystem   *enemyBehaviorSystem_;
  ProjectileSystem      *projectileSystem_;
  DamageSystem          *damageSystem_;
  GameStateSystem       *gameStateSystem_;
  UISystem              *UISystem_;
  
  UIView                *view_;
  
  NSMutableDictionary   *stateDictionary_;

  NSTimeInterval        timestepAccumulator_;
  NSTimeInterval        timestepAccumulatorRatio_;
  NSTimeInterval const  timestepInterval_;
}

@property (nonatomic) Camera          *camera;


- (id)initWithView:(UIView *)view;

- (void)update:(NSTimeInterval)elapsedTime;
- (void)step;
- (void)render;
- (void)loadMapFromFile:(NSString *)fileName;
- (void)createStateDictionary;

@end