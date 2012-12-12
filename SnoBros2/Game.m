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
#import "SpriteManager.h"
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
    [entityManager_ loadEntityTypesFromFile:@"entities"];
    [entityManager_ buildAndAddEntity:@"Map"];
    [self loadMapFromFile:@"map"];
    
    spriteManager_   = [[SpriteManager alloc] init];
    [spriteManager_ loadEntityTypesFromFile:@"sprites"];
    
    selectionSystem_ = [[SelectionSystem alloc]
                        initWithEntityManager:entityManager_];
    collisionSystem_ = [[CollisionSystem alloc]
                        initWithEntityManager:entityManager_];
    renderSystem_    = [[RenderSystem alloc]
                          initWithEntityManager:entityManager_
                                  spriteManager:spriteManager_
                                         camera:camera_];
    
    pathfindingSystem_   = [[PathfindingSystem alloc]
                            initWithEntityManager:entityManager_];
    movementSystem_      = [[MovementSystem alloc]
                            initWithEntityManager:entityManager_];
    enemyBehaviorSystem_ = [[EnemyBehaviorSystem alloc]
                            initWithEntityManager:entityManager_];
    projectileSystem_    = [[ProjectileSystem alloc] init];

    GLKVector2    target  = GLKVector2Make(192.f, 416.f);
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

  //[collisionSystem_     update];
  [movementSystem_      update];
  [enemyBehaviorSystem_ update];
  [renderSystem_ update];

  [camera_            update];
  [entityManager_ processQueue];
}



- (void)render {
  [renderSystem_ renderEntitieswithInterpolationRatio:timestepAccumulatorRatio_];
}



- (void)loadMapFromFile:(NSString *)fileName {
  NSError  *error;
  NSString *path = [[NSBundle mainBundle]
                    pathForResource:fileName ofType:@"json"];
  NSString *json = [[NSString alloc] initWithContentsOfFile:path
                                                   encoding:NSUTF8StringEncoding
                                                      error:&error];
  if (error) { NSLog(@"Error: %@", error); return; }
  
  NSData *data             = [json dataUsingEncoding:NSUTF8StringEncoding];
  NSDictionary *mapData = [NSJSONSerialization JSONObjectWithData:data
                                                             options:NSJSONReadingMutableContainers
                                                               error:&error];
  if (error) { NSLog(@"Error: %@", error); return; }
  
  if ([mapData isKindOfClass:[NSArray class]]) {
    for (NSDictionary *d in mapData) {
    }
  } else {
    NSDictionary *d = mapData[@"Objects"];
    for (id key in d) {
      Entity *e = [entityManager_ buildAndAddEntity:d[key]];
      if ([e.tag isEqualToString:@"maindude"]) {
        [selectionSystem_ selectEntity:e];
      }
      Transform *transform = [e getComponentByString:@"Transform"];
      NSArray *locs = [key componentsSeparatedByString:@","];
      int x = [[locs objectAtIndex:0] intValue], y = [[locs objectAtIndex:1] intValue];
      transform.position = GLKVector2Make(x * 32.f + 16.f, y * 32.f + 16.f);
    }
  }

}

@end