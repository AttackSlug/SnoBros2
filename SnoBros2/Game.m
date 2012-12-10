//
//  Game.m
//  SnoBros2
//
//  Created by Tanoy Sinha on 11/18/12.
//  Copyright (c) 2012 Attack Slug. All rights reserved.
//

#import "Game.h"
#import "Entity.h"
#import "Camera.h"

#import "EntityManager.h"
#import "InputSystem.h"
#import "CollisionSystem.h"
#import "RenderSystem.h"
#import "SelectionSystem.h"
#import "ShaderManager.h"
#import "PathfindingSystem.h"
#import "MovementSystem.h"
#import "EnemyBehaviorSystem.h"
#import "ProjectileSystem.h"

#import "Transform.h"
#import "Physics.h"

@implementation Game

@synthesize camera          = camera_;
@synthesize entityManager   = entityManager_;
@synthesize selectionSystem = selectionSystem_;

- (id)init {
  self = [super init];
  if (self) {
    timestepAccumulatorRatio_ = 1.f;

    camera_          = [[Camera alloc] init];
    entityManager_   = [[EntityManager alloc] init];
    selectionSystem_ = [[SelectionSystem alloc]
                        initWithEntityManager:entityManager_];
    collisionSystem_ = [[CollisionSystem alloc]
                        initWithEntityManager:entityManager_];
    renderSystem_    = [[RenderSystem alloc]
                        initWithEntityManager:entityManager_ camera:camera_];

    [entityManager_ loadEntityTypesFromFile:@"entities"];
    [entityManager_ buildAndAddEntity:@"Map"];

    Entity *e = [entityManager_ buildAndAddEntity:@"MainDude"];
    Transform *transform = [e getComponentByString:@"Transform"];
    transform.position = GLKVector2Make(0.f, 0.f);
    
    Entity *e1 = [entityManager_ buildAndAddEntity:@"Enemy"];
    Transform *transform1 = [e1 getComponentByString:@"Transform"];
    transform1.position = GLKVector2Make(80.f, 80.f);
    
    Entity *e2 = [entityManager_ buildAndAddEntity:@"Obstacle"];
    Transform *transform2 = [e2 getComponentByString:@"Transform"];
    transform2.position = GLKVector2Make(112.f, 48.f);
    
    pathfindingSystem_ = [[PathfindingSystem alloc]
                          initWithEntityManager:entityManager_];
    movementSystem_    = [[MovementSystem alloc]
                          initWithEntityManager:entityManager_];
    enemyBehaviorSystem_ = [[EnemyBehaviorSystem alloc]
                          initWithEntityManager:entityManager_];
    projectileSystem_    = [[ProjectileSystem alloc] init];


    GLKVector2    target  = GLKVector2Make(192.f, 128.f);
    NSDictionary *panData = @{@"target": [NSValue value:&target
                                           withObjCType:@encode(GLKVector2)]};
    [[NSNotificationCenter defaultCenter] postNotificationName:@"panCameraToTarget"
                                                        object:self
                                                      userInfo:panData];
  }
  return self;
}



- (void)update:(NSTimeInterval)elapsedTime {
  timestepAccumulator_ += elapsedTime;

  int numSteps = MIN(timestepAccumulator_ / TIMESTEP_INTERVAL, MAX_STEPS);
  if (numSteps > 0) {
    timestepAccumulator_ -= numSteps * TIMESTEP_INTERVAL;
  }

  timestepAccumulatorRatio_ = timestepAccumulator_ / TIMESTEP_INTERVAL;

  for (int i = 0; i < numSteps; i++) {
    [self step];
  }
}



- (void)step {
  for (Entity *e in [entityManager_ allEntities]) {
    [e update];
  }

  [collisionSystem_     update];
  [movementSystem_      update];
  [enemyBehaviorSystem_ update];

  [camera_            update];
  [entityManager_ processQueue];
}



- (void)render {
  [renderSystem_ renderEntitieswithInterpolationRatio:timestepAccumulatorRatio_];
}

@end