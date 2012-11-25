//
//  Game.m
//  SnoBros2
//
//  Created by Tanoy Sinha on 11/18/12.
//  Copyright (c) 2012 Cjab. All rights reserved.
//

#import "Game.h"
#import "Entity.h"
#import "Camera.h"

#import "EntityManager.h"
#import "InputSystem.h"
#import "CollisionSystem.h"

@implementation Game

@synthesize camera        = camera_;
@synthesize entityManager = entityManager_;

- (id)init {
  self = [super init];
  if (self) {
    timestepAccumulatorRatio_ = 1.f;

    camera_          = [[Camera alloc] init];
    entityManager_   = [[EntityManager alloc] init];
    collisionSystem_ = [[CollisionSystem alloc]
                        initWithEntityManager:entityManager_];

    [entityManager_ loadEntityTypesFromFile:@"entities"];
    [entityManager_ buildAndAddEntity:@"Map"];
    [entityManager_ buildAndAddEntity:@"Player"];
    [entityManager_ buildAndAddEntity:@"Sphere 1"];
    [entityManager_ buildAndAddEntity:@"Sphere 2"];
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
  [collisionSystem_ update];
  [camera_ update];
  [entityManager_ processQueue];
  [entityManager_ update];
}



- (void)render {
  for (Entity *e in [entityManager_ allSortedByLayer]) {
    [e renderWithCamera:camera_
     interpolationRatio:timestepAccumulatorRatio_];
  }
}

@end