//
//  Scene.m
//  Component
//
//  Created by Cjab on 11/6/12.
//  Copyright (c) 2012 Cjab. All rights reserved.
//

#import "Scene.h"

@implementation Scene


- (id)init {
  self = [super init];
  if (self) {
    entities_ = [[NSMutableArray alloc] init];
    [entities_ addObject:[self setupMap]];
    [entities_ addObject:[self setupPlayer]];
  }
  return self;
}



- (void)update {
  for (Entity *e in entities_) {
    [e update];
  }
}



- (void)render {
  for (Entity *e in entities_) {
    [e render];
  }
}



- (UIResponder *)nextResponder {
  for (Entity *e in entities_) {
    if(e.input) { return e.input; }
  }
  return nil;
}



- (void)addEntity:(Entity *)entity {
  [entities_ addObject:entity];
}



- (void)removeEntity:(Entity *)entity {
  [entities_ removeObject:entity];
}



- (Entity *)setupPlayer {
  Entity *player   = [[Entity alloc]    init];
  player.transform = [[Transform alloc] initWithEntity:player];
  player.sprite    = [[Sprite alloc]    initWithFile:@"player.png"];
  player.physics   = [[Physics alloc]   initWithEntity:player
                                             transform:player.transform];
  player.renderer  = [[Renderer alloc]  initWithEntity:player
                                             transform:player.transform
                                                sprite:player.sprite];
  player.behavior  = [[Behavior alloc]        initWithEntity:player
                                             transform:player.transform
                                               physics:player.physics];
  player.input     = [[Input alloc]     initWithEntity:player
                                              behavior:player.behavior];
  return player;
}



- (Entity *)setupMap {
  Entity *map   = [[Entity alloc] init];
  map.transform = [[Transform alloc] initWithEntity:map];
  map.sprite    = [[Sprite alloc]    initWithFile:@"map.png"];
  map.renderer  = [[Renderer alloc]  initWithEntity:map
                                          transform:map.transform
                                             sprite:map.sprite];
  map.transform.position = GLKVector2Make(map.renderer.width  / 2.f,
                                          map.renderer.height / 2.f);
  return map;
}


@end