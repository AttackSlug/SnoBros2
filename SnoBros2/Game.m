//
//  EventQueue.m
//  SnoBros2
//
//  Created by Tanoy Sinha on 11/18/12.
//  Copyright (c) 2012 Cjab. All rights reserved.
//

#import "Game.h"
#import "LeftPlayer.h"
#import "Sphere.h"
#import "Entity.h"
#import "Transform.h"
#import "Sprite.h"
#import "Physics.h"
#import "Renderer.h"
#import "Collision.h"
#import "Camera.h"
#import "EventManager.h"
#import "Selectable.h"
#import "Event.h"
#import "EntityManager.h"
#import "CollisionSystem.h"

@implementation Game

@synthesize camera        = camera_;
@synthesize eventManager  = eventManager_;

- (id)init {
  self = [super init];
  if (self) {
    camera_          = [[Camera alloc] init];

    entityManager_   = [[EntityManager alloc] init];
    eventManager_    = [[EventManager alloc] initWithCamera:camera_
                                              entityManager:entityManager_];
    collisionSystem_ = [[CollisionSystem alloc] initWithEventManager:eventManager_
                                                     entityManager:entityManager_];

    [entityManager_ add:[self setupMap]];
    [entityManager_ add:[self setupLeftPlayer]];

    timestepAccumulatorRatio_ = 1.f;

    Entity *sphere1 = [self setupSphere];
    Entity *sphere2 = [self setupSphere2];

    sphere1.transform.position = GLKVector2Make(100, 160);
    sphere2.transform.position = GLKVector2Make(300, 160);

    sphere1.physics.velocity = GLKVector2Make( 1, 0);
    sphere2.physics.velocity = GLKVector2Make(-1, 0);

    [entityManager_ add:sphere1];
    [entityManager_ add:sphere2];
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



- (Entity *)setupSphere {
  Entity *sphere   = [[Entity alloc]    initWithTag:@"sphere"];
  sphere.transform = [[Transform alloc] initWithEntity:sphere];
  sphere.sprite    = [[Sprite alloc]    initWithFile:@"snowball.png"];
  sphere.physics   = [[Physics alloc]   initWithEntity:sphere];
  sphere.renderer  = [[Renderer alloc]  initWithEntity:sphere
                                                sprite:sphere.sprite
                                                 layer:1];
  sphere.behavior  = [[Sphere alloc] initWithEntity:sphere];
  sphere.collision = [[Collision alloc] initWithEntity:sphere
                                         entityManager:entityManager_
                                                radius: 10.f];

  return sphere;
}



- (Entity *)setupSphere2 {
  Entity *sphere   = [[Entity alloc]    initWithTag:@"sphere"];
  sphere.transform = [[Transform alloc] initWithEntity:sphere];
  sphere.sprite    = [[Sprite alloc]    initWithFile:@"snowball-small.png"];
  sphere.physics   = [[Physics alloc]   initWithEntity:sphere];
  sphere.renderer  = [[Renderer alloc]  initWithEntity:sphere
                                                sprite:sphere.sprite
                                                 layer:1];
  sphere.behavior  = [[Sphere alloc] initWithEntity:sphere];
  sphere.collision = [[Collision alloc] initWithEntity:sphere
                                         entityManager:entityManager_
                                                radius: 5];

  return sphere;
}



- (Entity *)setupLeftPlayer {
  Entity *player   = [[Entity alloc]    initWithTag:@"player"];
  player.transform = [[Transform alloc] initWithEntity:player];
  player.sprite    = [[Sprite alloc]    initWithFile:@"sprite2.png"];
  player.physics   = [[Physics alloc]   initWithEntity:player];
  player.renderer  = [[Renderer alloc]  initWithEntity:player
                                                sprite:player.sprite
                                                 layer:1];
  player.behavior  = [[LeftPlayer alloc] initWithEntity:player];
  player.collision = [[Collision alloc] initWithEntity:player
                                         entityManager:entityManager_
                                                radius: 48.f];
  player.selectable = [[Selectable alloc] initWithEntity:player];

  player.transform.position = GLKVector2Make(20, 20);
  return player;
}



- (Entity *)setupMap {
  Entity *map   = [[Entity alloc] initWithTag:@"map"];
  map.transform = [[Transform alloc] initWithEntity:map];
  map.sprite    = [[Sprite alloc]    initWithFile:@"wpaper.jpg"];
  map.renderer  = [[Renderer alloc]  initWithEntity:map
                                             sprite:map.sprite
                                              layer:0];
  map.transform.position = GLKVector2Make(map.renderer.width  / 2.f,
                                          map.renderer.height / 2.f);
  return map;
}

@end
