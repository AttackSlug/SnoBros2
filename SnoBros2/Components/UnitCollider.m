//
//  UnitCollider.m
//  SnoBros2
//
//  Created by Chad Jablonski on 11/27/12.
//  Copyright (c) 2012 Attack Slug. All rights reserved.
//

#import "UnitCollider.h"

#import "Entity.h"
#import "Transform.h"
#import "Collision.h"

@implementation UnitCollider

- (id)initWithEntity:(Entity *)entity {
  self = [super initWithEntity:entity];
  if (self) {
    NSString *name = [entity_.uuid stringByAppendingString:@"|collidedWith"];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(collidedWith:)
                                                 name:name
                                               object:nil];
  }
  return self;
}



- (id)initWithEntity:(Entity *)entity dictionary:(NSDictionary *)data {
  return [self initWithEntity:entity];
}



- (void)collidedWith:(NSNotification *)notification {
  Entity *other = [notification userInfo][@"otherEntity"];
  [self resolveCollisionWith:other];
}



- (void)resolveCollisionWith:(Entity *)otherEntity {
  Transform *transform    = [entity_ getComponentByString:@"Transform"];
  GLKVector2 intersection = [self intersectionWith:otherEntity];

  [transform translate:intersection];
}



- (GLKVector2)intersectionWith:(Entity *)other {
  Collision *myCollision    = [entity_ getComponentByString:@"Collision"];
  Collision *otherCollision = [other getComponentByString:@"Collision"];
  Transform *myTransform    = [entity_ getComponentByString:@"Transform"];
  Transform *otherTransform = [other getComponentByString:@"Transform"];

  float radius       = myCollision.radius;
  float otherRadius  = otherCollision.radius;
  float distance     = GLKVector2Distance(myTransform.position,
                                          otherTransform.position);
  float overlap      = 1 - (distance / (radius + otherRadius));
  GLKVector2 centers = GLKVector2Subtract(myTransform.position,
                                          otherTransform.position);

  return GLKVector2MultiplyScalar(centers, overlap);
}

@end