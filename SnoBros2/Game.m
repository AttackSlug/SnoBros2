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
#import "UIManager.h"

#import "InputSystem.h"
#import "CollisionSystem.h"
#import "RenderSystem.h"
#import "SelectionSystem.h"
#import "PathfindingSystem.h"
#import "MovementSystem.h"
#import "EnemyBehaviorSystem.h"
#import "ProjectileSystem.h"
#import "DamageSystem.h"
#import "GameStateSystem.h"
#import "InputSystem.h"
#import "UISystem.h"
#import "GameLogicSystem.h"

#import "Transform.h"
#import "Physics.h"

@implementation Game

@synthesize camera = camera_;

- (id)initWithView:(UIView *)view {
  self = [super init];
  if (self) {
    timestepAccumulatorRatio_ = 1.f;
    
    view_            = view;
    
    camera_          = [[Camera alloc] init];
    
    entityManager_   = [[EntityManager alloc] init];
    [entityManager_ loadEntityTypesFromFile:@"entities"];
    Entity *e = [entityManager_ buildEntity:@"Map"];
    [entityManager_ add:e];
    [self loadMapFromFile:@"map"];
    
    spriteManager_   = [[SpriteManager alloc] init];
    [spriteManager_ loadEntityTypesFromFile:@"sprites"];
    
    UIManager_       = [[UIManager alloc] initWithView:view];
    
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
    damageSystem_        = [[DamageSystem alloc]
                            initWithEntityManager:entityManager_];
    gameStateSystem_     = [[GameStateSystem alloc] init];
    inputSystem_         = [[InputSystem alloc]
                            initWithView:view_
                            entityManager:entityManager_
                            UIManager:UIManager_
                            camera:camera_];
    UISystem_            = [[UISystem alloc]
                            initWithUIManager:UIManager_];
    gameLogicSystem_     = [[GameLogicSystem alloc] init];
    
    
    GLKVector2    target  = GLKVector2Make(192.f, 416.f);
    NSDictionary *panData = @{@"target": [NSValue value:&target
                                           withObjCType:@encode(GLKVector2)]};
    [[NSNotificationCenter defaultCenter] postNotificationName:@"panCameraToTarget"
                                                        object:self
                                                      userInfo:panData];
    
    [self createStateDictionary];
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
  [UIManager_ updateFPSWithTime:elapsedTime];
}



- (void)step {
  for (id object in stateDictionary_[gameStateSystem_.state]) {
    [object update];
  }
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
      Entity *e = [entityManager_ buildEntity:d[key]];
      [entityManager_ add:e];
      if ([e.type isEqualToString:@"MainDude"]) {
        [selectionSystem_ selectEntity:e];
      }
      Transform *transform = [e getComponentByString:@"Transform"];
      NSArray *locs = [key componentsSeparatedByString:@","];
      int x = [[locs objectAtIndex:0] intValue], y = [[locs objectAtIndex:1] intValue];
      transform.position = GLKVector2Make(x * 32.f + 16.f, y * 32.f + 16.f);
    }
  }
}



- (void)createStateDictionary {
  stateDictionary_ = [[NSMutableDictionary alloc] init];
  stateDictionary_[@"Paused"] = [[NSMutableArray alloc] init];
  stateDictionary_[@"Adjusting"] = [[NSMutableArray alloc] init];
  stateDictionary_[@"Playing"] = [[NSMutableArray alloc] init];
  
  NSMutableArray *adjusting = [[NSMutableArray alloc] init];
  [adjusting addObject:entityManager_];
  [adjusting addObject:gameLogicSystem_];
  [adjusting addObject:movementSystem_];
  [adjusting addObject:renderSystem_];
  [adjusting addObject:camera_];
  
  NSMutableArray *playing = [[NSMutableArray alloc] init];
  [playing addObject:entityManager_];
  [playing addObject:gameLogicSystem_];
  [playing addObject:collisionSystem_];
  [playing addObject:movementSystem_];
  [playing addObject:enemyBehaviorSystem_];
  [playing addObject:renderSystem_];
  [playing addObject:camera_];
  
  stateDictionary_[@"Adjusting"] = adjusting;
  stateDictionary_[@"Playing"] = playing;
}

@end