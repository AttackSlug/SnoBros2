//
//  Scene.m
//  Component
//
//  Created by Cjab on 11/6/12.
//  Copyright (c) 2012 Cjab. All rights reserved.
//

#import "Scene.h"
#import "LeftPlayer.h"
#import "RightPlayer.h"
#import "Sphere.h"

@implementation Scene

@synthesize camera   = camera_;
@synthesize entities = entities_;
@synthesize quadtree = quadtree_;


- (id)init {
  self = [super init];
  if (self) {
    entities_      = [[NSMutableDictionary alloc] init];
    entityQueue_   = [[NSMutableDictionary alloc] init];
    inputHandler_  = [[Input alloc] init];
    camera_        = [[Camera alloc] init];
    [self addEntity:[self setupMap]];
    [self addEntity:[self setupLeftPlayer]];

    quadtree_      = [[Quadtree alloc] initWithLevel:5
                                              bounds:CGRectMake(0, 0, 480, 320)];

    Entity *sphere1 = [self setupSphere];
    Entity *sphere2 = [self setupSphere2];

    sphere1.transform.position = GLKVector2Make(100, 160);
    sphere2.transform.position = GLKVector2Make(300, 160);

    sphere1.physics.velocity = GLKVector2Make( 1, 0);
    sphere2.physics.velocity = GLKVector2Make(-1, 0);


    [self addEntity:sphere1];
    [self addEntity:sphere2];


    [self processEntityQueue];
  }
  return self;
}



- (void)update {
  for (id key in entities_) {
    [[entities_ objectForKey:key] update];
  }
  
  [inputHandler_ executeTouches:[self getEntitiesByTag:@"player"]];
  [inputHandler_ clearTouches];

  [self processEntityQueue];

  [quadtree_ clear];
  for (id key in entities_) {
    [quadtree_ insert:[entities_ objectForKey:key]];
  }
}



- (void)render {
  for (id key in entities_) {
    [[entities_ objectForKey:key] renderWithCamera:camera_];
  }
}



- (void)addEntity:(Entity *)entity {
  [entityQueue_ setObject:entity forKey:entity.uuid];
}



- (void)removeEntity:(Entity *)entity {
  [entityQueue_ setObject:entity forKey:entity.uuid];
}



// check the entity queue for adding entities to the main entity list
// use the entity queue to prevent modifying the entity list while iterating through it
// if we find an entity in the entity queue and in the main entity list, assume we request its deletion
// if we find an entity in the entity queue and not in the main entity list, assume we request its insertion
- (void)processEntityQueue {
  for (id key in entityQueue_) {
    Entity *temp = [entityQueue_ objectForKey:key];
    if ([entities_ objectForKey:key] == nil) {
      [entities_ setObject:temp forKey:key];
    } else {
      [entities_ removeObjectForKey:key];
    }
  }
  [entityQueue_ removeAllObjects];
}



-(NSMutableArray*)getEntitiesByTag:(NSString *)tag {
  NSMutableArray *ret = [[NSMutableArray alloc] initWithCapacity:0];
  for (id key in entities_) {
    Entity *temp = [entities_ objectForKey:key];
    if ([temp.tag isEqualToString:tag]) {
      [ret addObject:temp];
    }
  }
  return ret;
}



- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
  NSLog(@"Touched Screen");
  for (UITouch *touch in touches) {
    [inputHandler_ addTouch:touch];
  }
}



- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
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
                                              scene:self];
  sphere.collision = [[Collision alloc] initWithEntity:sphere
                                             transform:sphere.transform
                                               physics:sphere.physics
                                                 scene:self
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
                                              scene:self];
  sphere.collision = [[Collision alloc] initWithEntity:sphere
                                             transform:sphere.transform
                                               physics:sphere.physics
                                                 scene:self
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
                                                  scene:self];
  player.collision = [[Collision alloc] initWithEntity:player
                                             transform:player.transform
                                               physics:player.physics
                                                 scene:self
                                                radius: 48.f];
  return player;
}



- (Entity *)setupRightPlayer {
  Entity *player   = [[Entity alloc]    initWithTag:@"player"];
  player.transform = [[Transform alloc] initWithEntity:player];
  player.sprite    = [[Sprite alloc]    initWithFile:@"player.png"];
  player.physics   = [[Physics alloc]   initWithEntity:player
                                             transform:player.transform];
  player.renderer  = [[Renderer alloc]  initWithEntity:player
                                             transform:player.transform
                                                sprite:player.sprite];
  player.behavior  = [[RightPlayer alloc] initWithEntity:player
                                               transform:player.transform
                                                 physics:player.physics
                                                   scene:self];
  player.transform.position = GLKVector2Make(player.renderer.width,
                                             player.renderer.height);
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
