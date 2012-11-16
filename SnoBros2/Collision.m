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
    if (e == entity_ || !e.collision) { /*NSLog(@"HERE");*/ continue; }
    float otherRadius = e.collision.radius;
    float distance    = GLKVector2Distance(transform_.position,
                                           e.transform.position);
    if (distance < (radius_ + otherRadius)) {
      [physics_ resolveCollisionWith:e];
    }
  }
}



- (CGRect)boundingBox {
  return CGRectMake(transform_.position.x, transform_.position.y,
                    radius_, radius_);
}


@end