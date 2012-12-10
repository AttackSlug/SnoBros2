//
//  Attack.m
//  SnoBros2
//
//  Created by Chad Jablonski on 11/25/12.
//  Copyright (c) 2012 Attack Slug. All rights reserved.
//

#import "Attack.h"

#import "Entity.h"
#import "Transform.h"
#import "Physics.h"
#import "Projectile.h"
#import "Component.h"
#import "Collision.h"

@implementation Attack

@synthesize range = range_;

- (id)initWithEntity:(Entity *)entity {
  return [super initWithEntity:entity];
}



- (id)initWithEntity:(Entity *)entity dictionary:(NSDictionary *)data {
  self = [self initWithEntity:entity];
  if (self) {
    range_ = [data[@"Range"] floatValue];
    rate_  = [data[@"Rate"] floatValue];
  }
  return [self initWithEntity:entity];
}



- (void)fireAt:(GLKVector2)target {
  NSTimeInterval now = [[NSDate date] timeIntervalSince1970];
  if (now - lastFired_ < rate_) {
    return;
  }
  lastFired_ = [[NSDate date] timeIntervalSince1970];

  [self createProjectile:target];
}


- (void)createProjectile:(GLKVector2)target {
  Transform *transform = [entity_ getComponentByString:@"Transform"];
  Collision *collision = [entity_ getComponentByString:@"Collision"];

  void (^callback)(Entity *) = ^(Entity *projectile){
    Transform  *projTransform   = [projectile getComponentByString:@"Transform"];
    Physics    *projPhysics     = [projectile getComponentByString:@"Physics"];
    Projectile *projComponent   = [projectile getComponentByString:@"Projectile"];

    GLKVector2 path      = GLKVector2Subtract(transform.position, target);
    GLKVector2 direction = GLKVector2Normalize(path);
    GLKVector2 offset    = GLKVector2MultiplyScalar(direction, collision.radius);

    projTransform.position = GLKVector2Subtract(transform.position, offset);
    projPhysics.velocity   = GLKVector2Make(10.f, 0.f);
    projComponent.target   = target;
  };
  NSDictionary *data = @{@"type": @"Projectile", @"callback": callback};

  [[NSNotificationCenter defaultCenter] postNotificationName:@"createEntity"
                                                      object:self
                                                    userInfo:data];
}

@end