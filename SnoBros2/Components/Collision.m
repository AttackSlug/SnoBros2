//
//  Collision.m
//  SnoBros2
//
//  Created by Chad Jablonski on 11/12/12.
//  Copyright (c) 2012 Attack Slug. All rights reserved.
//

#import "Collision.h"

#import "Entity.h"
#import "Transform.h"

#include "BoundingBox.h"

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



- (id)initWithEntity:(Entity *)entity dictionary:(NSDictionary *)data {
  float radius = [data[@"Radius"] floatValue];
  return [self initWithEntity:entity radius:radius];
}



- (BoundingBox *)boundingBox {
  Transform *transform = [entity_ getComponentByString:@"Transform"];
  return [[BoundingBox alloc] initWithOrigin:transform.position
                                        size:CGSizeMake(radius_, radius_)];
}

@end