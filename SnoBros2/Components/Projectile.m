//
//  Projectile.m
//  SnoBros2
//
//  Created by Chad Jablonski on 11/25/12.
//  Copyright (c) 2012 Attack Slug. All rights reserved.
//

#import "Projectile.h"

#import "Entity.h"
#import "Transform.h"
#import "Physics.h"

@implementation Projectile

@synthesize target = target_;

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
  self = [self initWithEntity:entity];
  if (self) {
    damage_ = [data[@"Damage"] integerValue];
  }
  return self;
}



- (void)update {
  if (!target_) { return; }

  Transform *targetTransform = [target_ getComponentByString:@"Transform"];
  Transform *transform       = [entity_ getComponentByString:@"Transform"];
  Physics   *physics         = [entity_ getComponentByString:@"Physics"];

  GLKVector2 targetPosition  = targetTransform.position;
  GLKVector2 position        = transform.position;

  GLKVector2 direction = GLKVector2Normalize(GLKVector2Subtract(targetPosition,
                                                                position));
  physics.velocity = GLKVector2MultiplyScalar(direction, 10);
}



- (void)collidedWith:(NSNotification *)notification {
  Entity *otherEntity = [notification userInfo][@"otherEntity"];

  if (otherEntity == target_) {
    NSValue  *damageVal  = [NSValue value:&damage_ withObjCType:@encode(int *)];
    NSString *takeDamage = [target_.uuid stringByAppendingString:@"|takeDamage"];
    NSDictionary *damageData = @{@"amount": damageVal};
    [[NSNotificationCenter defaultCenter] postNotificationName:takeDamage
                                                        object:self
                                                      userInfo:damageData];

    target_ = nil;
    NSDictionary *destroyData = @{@"entity": entity_};
    [[NSNotificationCenter defaultCenter] postNotificationName:@"destroyEntity"
                                                        object:self
                                                      userInfo:destroyData];
  }
}

@end