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



- (CGRect)boundingBox {
  Transform *transform = [entity_ getComponentByString:@"Transform"];
  return CGRectMake(transform.position.x,
                    transform.position.y,
                    radius_, radius_);
}

@end