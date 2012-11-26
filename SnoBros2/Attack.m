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
#import "Projectile.h"
#import "Component.h"
#import "Collision.h"

@implementation Attack

- (id)initWithEntity:(Entity *)entity {
  return [super initWithEntity:entity];
}



- (id)initWithEntity:(Entity *)entity dictionary:(NSDictionary *)data {
  return [self initWithEntity:entity];
}



- (void)fireAt:(Entity *)target {
  Transform *transform = [entity_ getComponentByString:@"Transform"];
  Collision *collision = [entity_ getComponentByString:@"Collision"];

  void (^callback)(Entity *) = ^(Entity *projectile){
    Transform  *projTransform   = [projectile getComponentByString:@"Transform"];
    Physics    *projPhysics     = [projectile getComponentByString:@"Physics"];
    Projectile *projComponent   = [projectile getComponentByString:@"Projectile"];
    Transform  *targetTransform = [target getComponentByString:@"Transform"];

    GLKVector2 path      = GLKVector2Subtract(transform.position,
                                              targetTransform.position);
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