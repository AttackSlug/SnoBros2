//
//  EventQueue.m
//  SnoBros2
//
//  Created by Tanoy Sinha on 11/18/12.
//  Copyright (c) 2012 Cjab. All rights reserved.
//

#import "Game.h"
#import "Camera.h"
#import "EventManager.h"
#import "EntityManager.h"
#import "CollisionSystem.h"

#import "Entity.h"

@implementation Game

@synthesize camera        = camera_;
@synthesize eventManager  = eventManager_;

- (id)init {
  self = [super init];
  if (self) {
    timestepAccumulatorRatio_ = 1.f;

    camera_          = [[Camera alloc] init];
    entityManager_   = [[EntityManager alloc] init];
    eventManager_    = [[EventManager alloc] initWithCamera:camera_
                                              entityManager:entityManager_];
    collisionSystem_ = [[CollisionSystem alloc] initWithEventManager:eventManager_
                                                       entityManager:entityManager_];

    [entityManager_ loadFromFile:@"entities"];
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
  [camera_ updateWithEventManager:self.eventManager];
  [entityManager_ processQueue];
  [entityManager_ update];
  [eventManager_ executeEvents];
  [eventManager_ clearEvents];
}



- (void)render {
  for (Entity *e in [entityManager_ allSortedByLayer]) {
    [e renderWithCamera:camera_
     interpolationRatio:timestepAccumulatorRatio_];
  }
}

@end