//
//  EventQueue.m
//  SnoBros2
//
//  Created by Tanoy Sinha on 11/18/12.
//  Copyright (c) 2012 Cjab. All rights reserved.
//

#import "EventQueue.h"
#import "LeftPlayer.h"
#import "Sphere.h"
#import "Entity.h"
#import "EntityManager.h"
#import "Transform.h"
#import "Sprite.h"
#import "Physics.h"
#import "Renderer.h"
#import "Collision.h"
#import "Camera.h"

@implementation EventQueue

@synthesize camera = camera_;

- (id)init {
  self = [super init];
  if (self) {
    camera_        = [[Camera alloc] init];
    entityManager_ = [[EntityManager alloc] init];
    events_ = [[NSMutableArray alloc] initWithCapacity:0];
    
    
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



- (id)initWithEntityManager:(EntityManager *)entityManager {
  self = [super init];
  if (self) {
    entityManager_ = entityManager;
    events_ = [[NSMutableArray alloc] initWithCapacity:0];
  }
  return self;
}



- (void)addEvent:(Event *)e {
  [events_ addObject:e];
}



- (void)addOneFingerTapEvent:(UITapGestureRecognizer *)gr {
  NSLog(@"one finger tap from event queue");
  NSArray *players = [entityManager_ findByTag:@"player"];
  Entity *player = [players objectAtIndex:0];
  CGPoint p = [gr locationInView:gr.view];
  GLKVector2 pos = GLKVector2Make(p.x, p.y);
  
  Event *e = [[Event alloc] initWithID:player.uuid
                           Selector:@selector(walkTo:)
                            Payload:[NSValue value:&pos withObjCType:@encode(GLKVector2)]];
  [events_ addObject:e];
}



- (void)addTwoFingerTapEvent:(UITapGestureRecognizer *)gr {
  NSLog(@"two finger tap from event queue");
}



- (void)executeEvents {
  for (Event *e in events_) {
    Entity *ent = [entityManager_ findById:e.entityID];
    [ent.behavior performSelector:e.func withObject:e.payload];
  }
}



- (void)clearEvents {
  [events_ removeAllObjects];
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
  
  [entityManager_ processQueue];
  [entityManager_ update];
}



- (void)render {
  for (Entity *e in [entityManager_ allEntities]) {
    [e renderWithCamera:camera_
     interpolationRatio:timestepAccumulatorRatio_];
  }
}



- (Entity *)setupSphere {
  Entity *sphere   = [[Entity alloc]    initWithTag:@"sphere"];
  sphere.transform = [[Transform alloc] initWithEntity:sphere];
  sphere.sprite    = [[Sprite alloc]    initWithFile:@"snowball.png"];
  sphere.physics   = [[Physics alloc]   initWithEntity:sphere
                                             transform:sphere.transform];
  sphere.renderer  = [[Renderer alloc]  initWithEntity:sphere
                                             transform:sphere.transform
                                                sprite:sphere.sprite];
  sphere.behavior  = [[Sphere alloc] initWithEntity:sphere
                                          transform:sphere.transform
                                            physics:sphere.physics
                                              scene:self
                                      entityManager:entityManager_];
  sphere.collision = [[Collision alloc] initWithEntity:sphere
                                             transform:sphere.transform
                                               physics:sphere.physics
                                         entityManager:entityManager_
                                                radius: 10.f];
  
  return sphere;
}



- (Entity *)setupSphere2 {
  Entity *sphere   = [[Entity alloc]    initWithTag:@"sphere"];
  sphere.transform = [[Transform alloc] initWithEntity:sphere];
  sphere.sprite    = [[Sprite alloc]    initWithFile:@"snowball-small.png"];
  sphere.physics   = [[Physics alloc]   initWithEntity:sphere
                                             transform:sphere.transform];
  sphere.renderer  = [[Renderer alloc]  initWithEntity:sphere
                                             transform:sphere.transform
                                                sprite:sphere.sprite];
  sphere.behavior  = [[Sphere alloc] initWithEntity:sphere
                                          transform:sphere.transform
                                            physics:sphere.physics
                                              scene:self
                                      entityManager:entityManager_];
  sphere.collision = [[Collision alloc] initWithEntity:sphere
                                             transform:sphere.transform
                                               physics:sphere.physics
                                         entityManager:entityManager_
                                                radius: 5];
  
  return sphere;
}



- (Entity *)setupLeftPlayer {
  Entity *player   = [[Entity alloc]    initWithTag:@"player"];
  player.transform = [[Transform alloc] initWithEntity:player];
  player.sprite    = [[Sprite alloc]    initWithFile:@"sprite2.png"];
  player.physics   = [[Physics alloc]   initWithEntity:player
                                             transform:player.transform];
  player.renderer  = [[Renderer alloc]  initWithEntity:player
                                             transform:player.transform
                                                sprite:player.sprite];
  player.behavior  = [[LeftPlayer alloc] initWithEntity:player
                                              transform:player.transform
                                                physics:player.physics
                                                  scene:self
                                          entityManager:entityManager_];
  player.collision = [[Collision alloc] initWithEntity:player
                                             transform:player.transform
                                               physics:player.physics
                                         entityManager:entityManager_
                                                radius: 48.f];
  
  player.transform.position = GLKVector2Make(20, 20);
  return player;
}



- (Entity *)setupMap {
  Entity *map   = [[Entity alloc] initWithTag:@"map"];
  map.transform = [[Transform alloc] initWithEntity:map];
  map.sprite    = [[Sprite alloc]    initWithFile:@"wpaper.jpg"];
  map.renderer  = [[Renderer alloc]  initWithEntity:map
                                          transform:map.transform
                                             sprite:map.sprite];
  map.transform.position = GLKVector2Make(map.renderer.width  / 2.f,
                                          map.renderer.height / 2.f);
  return map;
}


@end
