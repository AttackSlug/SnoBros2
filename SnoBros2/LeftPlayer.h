//
//  LeftPlayer.h
//  Component
//
//  Created by Cjab on 11/7/12.
//  Copyright (c) 2012 Cjab. All rights reserved.
//

#import "Behavior.h"

@class EventQueue;
@class Physics;
@class Transform;
@class EntityManager;
@class Entity;

@interface LeftPlayer : Behavior

- (id)initWithEntity:(Entity *)entity
           transform:(Transform *)transform
             physics:(Physics *)physics
               scene:(EventQueue *)scene
       entityManager:(EntityManager *)entityManager;
- (void)walkTo:(NSValue*)message;

@end
