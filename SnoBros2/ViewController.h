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

@interface ViewController : GLKViewController {
  NSMutableDictionary *entities_;
  NSMutableDictionary *entityQueue_;
  Camera              *camera_;
  Quadtree            *quadtree_;
  Input               *inputHandler_;
}

@property (nonatomic) Camera *camera;

@property NSMutableDictionary *entities;
@property Quadtree            *quadtree;

- (void)update;
- (void)render;
- (void)addEntity:(Entity *)entity;
- (void)removeEntity:(Entity *)entity;
- (void)processEntityQueue;
- (NSMutableArray*)getEntitiesByTag:(NSString*)tag;
- (void)setupGL;

@end
