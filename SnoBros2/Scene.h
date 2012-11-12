//
//  Scene.h
//  Component
//
//  Created by Cjab on 11/6/12.
//  Copyright (c) 2012 Cjab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Entity.h"

@interface Scene : UIResponder {
  NSMutableDictionary *entities_;
  NSMutableDictionary *entityQueue_;
  NSMutableArray *inputHandlers_;
}

- (id)init;

- (void)update;
- (void)render;

- (void)addEntity:(Entity *)entity;
- (void)removeEntity:(Entity *)entity;
- (void)processEntityQueue;
- (NSMutableArray*)getEntitiesByTag:(NSString*)tag;

@end