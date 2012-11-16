//
//  Scene.h
//  Component
//
//  Created by Cjab on 11/6/12.
//  Copyright (c) 2012 Cjab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Entity.h"
#import "Camera.h"
#import "Quadtree.h"
#import "Input.h"

@interface Scene : UIResponder {
  NSMutableDictionary *entities_;
  NSMutableDictionary *entityQueue_;
  Camera              *camera_;
  Quadtree            *quadtree_;
  Input               *inputHandler_;
}

@property (nonatomic) Camera *camera;

@property NSMutableDictionary *entities;
@property Quadtree            *quadtree;

- (id)init;

- (void)update;
- (void)render;
- (void)addEntity:(Entity *)entity;
- (void)removeEntity:(Entity *)entity;
- (void)processEntityQueue;
- (NSMutableArray*)getEntitiesByTag:(NSString*)tag;

@end