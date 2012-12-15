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
#import "Collision.h"

@implementation Projectile

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



- (void)setTarget:(GLKVector2)target  {
  target_ = target;
  NSDictionary *walkToData = @{
    @"entity":  entity_,
    @"target": [NSValue value:&target_ withObjCType:@encode(GLKVector2)]

  };
  [[NSNotificationCenter defaultCenter] postNotificationName:@"walkTo"
                                                      object:self
                                                    userInfo:walkToData];
}



- (void)collidedWith:(NSNotification *)notification {
  Entity *otherEntity  = [notification userInfo][@"otherEntity"];

  NSValue  *damageVal  = [NSValue value:&damage_ withObjCType:@encode(int *)];
  NSDictionary *damageData = @{@"amount": damageVal, @"entity": otherEntity};
  [[NSNotificationCenter defaultCenter] postNotificationName:@"takeDamage"
                                                      object:self
                                                    userInfo:damageData];

  NSDictionary *destroyData = @{@"entity": entity_};
  [[NSNotificationCenter defaultCenter] postNotificationName:@"destroyEntity"
                                                      object:self
                                                    userInfo:destroyData];
}

@end