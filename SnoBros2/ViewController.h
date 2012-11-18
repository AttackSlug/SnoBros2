//
//  ViewController.h
//  Component
//
//  Created by Cjab on 11/4/12.
//  Copyright (c) 2012 Cjab. All rights reserved.
//

#import <GLKit/GLKit.h>

@class Camera;
@class Quadtree;
@class Input;
@class EntityManager;

const static float TIMESTEP_INTERVAL = 1.f / 60.f;
const static int   MAX_STEPS         = 5;

@interface ViewController : GLKViewController {
  EntityManager       *entityManager_;
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
- (void)update;
- (void)step;
- (void)render;
- (void)setupGL;

@end