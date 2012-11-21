//
//  Collision.m
//  SnoBros2
//
//  Created by Cjab on 11/12/12.
//  Copyright (c) 2012 Cjab. All rights reserved.
//

#import "Collision.h"

#import "Entity.h"
#import "Transform.h"

@implementation Collision

@synthesize radius = radius_;

- (id)initWithEntity:(Entity *)entity
              radius:(float)radius {
  self = [super initWithEntity:entity];
  if (self) {
    radius_ = radius;
  }
  return self;
}



- (CGRect)boundingBox {
  return CGRectMake(entity_.transform.position.x,
                    entity_.transform.position.y,
                    radius_, radius_);
}

@end