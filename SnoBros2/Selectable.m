//
//  Selectable.m
//  SnoBros2
//
//  Created by Tanoy Sinha on 11/20/12.
//  Copyright (c) 2012 Cjab. All rights reserved.
//

#import "Selectable.h"
#import "Sprite.h"
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



- (BOOL)isAtLocation:(GLKVector2)location {
  GLKVector2 pos = entity_.transform.position;
  GLKVector2 size = GLKVector2Make(entity_.sprite.width, entity_.sprite.height);
  
  return (location.x > pos.x - size.x/2 &&
          location.x < pos.x + size.x/2 &&
          location.y > pos.y - size.y/2 &&
          location.y < pos.y + size.y/2);
}



- (BOOL)isInRectangle:(CGRect)rectangle {
  GLKVector2 pos = entity_.transform.position;
  return (pos.x > rectangle.origin.x &&
          pos.x < rectangle.origin.x + rectangle.size.width &&
          pos.y > rectangle.origin.y &&
          pos.y < rectangle.origin.y + rectangle.size.height);
}

@end
