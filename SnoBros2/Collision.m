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
       entityManager:(EntityManager *)entityManager
              radius:(float)radius {
  self = [super initWithEntity:entity];
  if (self) {
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
     float distance    = GLKVector2Distance(entity_.transform.position,
                                            otherEntity.transform.position);

     if (distance < (radius_ + otherRadius)) {
       float overlap           = 1 - (distance / (radius_ + otherRadius));
       GLKVector2 centers      = GLKVector2Subtract(entity_.transform.position,
                                                    otherEntity.transform.position);
       GLKVector2 intersection = GLKVector2MultiplyScalar(centers, overlap);

       [entity_.physics resolveCollisionWith:otherEntity
                                intersection:intersection];
    }
  }
}



- (CGRect)boundingBox {
  return CGRectMake(entity_.transform.position.x,
                    entity_.transform.position.y,
                    radius_, radius_);
}

@end