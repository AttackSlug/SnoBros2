//
//  Attack.m
//  SnoBros2
//
//  Created by Cjab on 11/25/12.
//  Copyright (c) 2012 Cjab. All rights reserved.
//

#import "Attack.h"

#import "Entity.h"
#import "Transform.h"
#import "Physics.h"

@implementation Attack

- (id)initWithEntity:(Entity *)entity {
  return [super initWithEntity:entity];
}



- (id)initWithEntity:(Entity *)entity dictionary:(NSDictionary *)data {
  return [self initWithEntity:entity];
}



- (void)fireAt:(Entity *)entity {
  Transform *transform = [entity getComponentByString:@"Transform"];

  void (^callback)(Entity *) = ^(Entity *projectile){
    Transform *projTransform = [projectile getComponentByString:@"Transform"];
    Physics   *projPhysics   = [projectile getComponentByString:@"Physics"];

    projTransform.position = transform.position;
    projPhysics.velocity   = GLKVector2Make(10.f, 0.f);
  };
  NSDictionary *data = @{@"type": @"Projectile", @"callback": callback};

  [[NSNotificationCenter defaultCenter] postNotificationName:@"createEntity"
                                                      object:self
                                                    userInfo:data];
}

@end