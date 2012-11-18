//
//  Collision.m
//  SnoBros2
//
//  Created by Cjab on 11/12/12.
//  Copyright (c) 2012 Cjab. All rights reserved.
//

#import "Collision.h"

#import "Entity.h"
#import "ViewController.h"
#import "Quadtree.h"
#import "Physics.h"
#import "Transform.h"
#import "EntityManager.h"

@implementation Collision


@synthesize radius = radius_;


- (id)initWithEntity:(Entity *)entity
           transform:(Transform *)transform
             physics:(Physics *)physics
       entityManager:(EntityManager *)entityManager
              radius:(float)radius {
  self = [super initWithEntity:entity];
  if (self) {
    transform_     = transform;
    physics_       = physics;
    entityManager_ = entityManager;
    radius_        = radius;
  }
  return self;
}



- (void)update {
  NSArray *nearbyEntities = [entityManager_ entitiesNear:entity_];


  for (Entity *otherEntity in nearbyEntities) {
     if (otherEntity == entity_ || !otherEntity.collision) { continue; }

     float otherRadius = otherEntity.collision.radius;
     float distance    = GLKVector2Distance(transform_.position,
                                           otherEntity.transform.position);

     if (distance < (radius_ + otherRadius)) {
       float overlap           = 1 - (distance / (radius_ + otherRadius));
       GLKVector2 centers      = GLKVector2Subtract(transform_.position,
                                                   otherEntity.transform.position);
       GLKVector2 intersection = GLKVector2MultiplyScalar(centers, overlap);

       [physics_ resolveCollisionWith:otherEntity intersection:intersection];
    }
  }
}



- (CGRect)boundingBox {
  return CGRectMake(transform_.position.x, transform_.position.y,
                    radius_, radius_);
}


@end