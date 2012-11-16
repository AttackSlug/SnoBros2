//
//  ViewController.h
//  Component
//
//  Created by Cjab on 11/4/12.
//  Copyright (c) 2012 Cjab. All rights reserved.
//

#import <GLKit/GLKit.h>
#import "Entity.h"
#import "Camera.h"
#import "Quadtree.h"
#import "Input.h"

const static float TIMESTEP_INTERVAL = 1.f / 60.f;
const static int   MAX_STEPS         = 5;

@interface ViewController : GLKViewController {
  NSMutableDictionary *entities_;
  NSMutableDictionary *entityQueue_;
  Camera              *camera_;
  Quadtree            *quadtree_;
  Input               *inputHandler_;
  NSTimeInterval       timestepAccumulator_;
  NSTimeInterval       timestepAccumulatorRatio_;
  NSTimeInterval const timestepInterval_;
}

@property (nonatomic) Camera *camera;

@property NSMutableDictionary *entities;
@property Quadtree            *quadtree;


- (void)update:(NSTimeInterval)elapsedTime;
- (void)step;
- (void)render;
- (void)addEntity:(Entity *)entity;
- (void)removeEntity:(Entity *)entity;
- (void)processEntityQueue;
- (NSMutableArray*)getEntitiesByTag:(NSString*)tag;
- (void)setupGL;

@end
