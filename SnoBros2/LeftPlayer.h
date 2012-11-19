//
//  LeftPlayer.h
//  Component
//
//  Created by Cjab on 11/7/12.
//  Copyright (c) 2012 Cjab. All rights reserved.
//

#import "Behavior.h"

@class ViewController;
@class Physics;
@class Transform;
@class EntityManager;
@class Entity;

@interface LeftPlayer : Behavior

- (id)initWithEntity:(Entity *)entity
           transform:(Transform *)transform
             physics:(Physics *)physics
               scene:(ViewController *)scene
       entityManager:(EntityManager *)entityManager;
- (void)walkTo:(GLKVector2)target;

@end
