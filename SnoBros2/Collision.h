//
//  Collision.h
//  SnoBros2
//
//  Created by Cjab on 11/12/12.
//  Copyright (c) 2012 Cjab. All rights reserved.
//

#include "Component.h"

@class ViewController;
@class Entity;
@class EntityManager;
@class Physics;
@class Transform;

@interface Collision : Component {
  EntityManager   *entityManager_;
  float           radius_;
}


@property (nonatomic) float radius;


- (id)initWithEntity:(Entity *)entity
       entityManager:(EntityManager *)entityManager
              radius:(float)radius;

- (void)update;
- (CGRect)boundingBox;

@end