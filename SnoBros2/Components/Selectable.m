//
//  Selectable.m
//  SnoBros2
//
//  Created by Tanoy Sinha on 11/20/12.
//  Copyright (c) 2012 Attack Slug. All rights reserved.
//

#import "Selectable.h"
#import "Collision.h"
#import "Transform.h"
#import "Entity.h"
#import "Sprite.h"

#import "BoundingBox.h"

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
  Transform *transform = [entity_ getComponentByString:@"Transform"];
  Collision *collision = [entity_ getComponentByString:@"Collision"];
  GLKVector2 position = transform.position;
  float radius        = collision.radius;
  float distance      = GLKVector2Distance(position, location);

  return distance <= radius;
}



- (BOOL)isInBoundingBox:(BoundingBox *)boundingBox {
  Transform *transform = [entity_ getComponentByString:@"Transform"];
  return [boundingBox containsPoint:CGPointMake(transform.position.x,
                                                transform.position.y)];
}



- (void)selectUnit {
  selected_ = TRUE;
}



- (void)deselectUnit {
  selected_ = FALSE;
}

@end