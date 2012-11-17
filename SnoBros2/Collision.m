//
//  Collision.m
//  SnoBros2
//
//  Created by Cjab on 11/12/12.
//  Copyright (c) 2012 Cjab. All rights reserved.
//

#import "Collision.h"
#import "ViewController.h"
#import "Quadtree.h"

@implementation Collision


@synthesize radius = radius_;


- (id)initWithEntity:(Entity *)entity
           transform:(Transform *)transform
             physics:(Physics *)physics
               scene:(ViewController *)scene
              radius:(float)radius {
  self = [super initWithEntity:entity];
  if (self) {
    transform_ = transform;
    physics_   = physics;
    scene_     = scene;
    radius_    = radius;
  }
  return self;
}



- (void)update {
  NSMutableArray *ents = [scene_.quadtree retrieve:entity_];

  for (Entity *e in ents) {
    if (e == entity_ || !e.collision) { continue; }

    float otherRadius = e.collision.radius;
    float distance    = GLKVector2Distance(transform_.position,
                                           e.transform.position);

    if (distance < (radius_ + otherRadius)) {
      float overlap           = 1 - (distance / (radius_ + otherRadius));
      GLKVector2 centers      = GLKVector2Subtract(transform_.position,
                                                   e.transform.position);
      GLKVector2 intersection = GLKVector2MultiplyScalar(centers, overlap);

      [physics_ resolveCollisionWith:e intersection:intersection];
    }
  }
}



- (CGRect)boundingBox {
  return CGRectMake(transform_.position.x, transform_.position.y,
                    radius_, radius_);
}


@end
