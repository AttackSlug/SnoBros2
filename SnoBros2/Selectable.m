//
//  Selectable.m
//  SnoBros2
//
//  Created by Tanoy Sinha on 11/20/12.
//  Copyright (c) 2012 Cjab. All rights reserved.
//

#import "Selectable.h"
#import "Collision.h"
#import "Transform.h"
#import "Entity.h"

@implementation Selectable

@synthesize selected = selected_;

- (id)initWithEntity:(Entity *)entity {
  self = [super initWithEntity:entity];
  if (self) {
    selected_ = FALSE;
  }
  return self;
}



- (id)initWithEntity:(Entity *)entity dictionary:(NSDictionary *)data {
  return [self initWithEntity:entity];
}



- (BOOL)isAtLocation:(GLKVector2)location {
  GLKVector2 position = entity_.transform.position;
  float radius        = entity_.collision.radius;
  float distance      = GLKVector2Distance(position, location);

  return distance <= radius;
}



- (BOOL)isInRectangle:(CGRect)rectangle {
  GLKVector2 pos = entity_.transform.position;
  return (pos.x > rectangle.origin.x &&
          pos.x < rectangle.origin.x + rectangle.size.width &&
          pos.y > rectangle.origin.y &&
          pos.y < rectangle.origin.y + rectangle.size.height);
}

@end
