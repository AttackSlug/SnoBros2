//
//  ProjectileSystem.m
//  SnoBros2
//
//  Created by Cjab on 12/10/12.
//  Copyright (c) 2012 Attack Slug. All rights reserved.
//

#import "ProjectileSystem.h"

#import "Entity.h"
#import "Projectile.h"

@implementation ProjectileSystem

- (id)init {
  self = [super init];
  if (self) {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleArrivedAtTarget:)
                                                 name:@"arrivedAtTarget"
                                               object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleCollidedWith:)
                                                 name:@"collidedWith"
                                               object:nil];
  }
  return self;
}



- (void)handleArrivedAtTarget:(NSNotification *)notification {
  Entity *entity = [notification userInfo][@"entity"];

  if ([entity hasComponent:@"Projectile"]) {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"destroyEntity"
                                                        object:self
                                                      userInfo:@{@"entity": entity}];
  }
}



- (void)handleCollidedWith:(NSNotification *)notification {
  Entity *entity = [notification userInfo][@"entity"];

  if (![entity hasComponent:@"Projectile"]) {
    return;
  }

  Entity     *otherEntity  = [notification userInfo][@"otherEntity"];
  Projectile *projectile   = [entity getComponentByString:@"Projectile"];
  int         damage       = projectile.damage;
  NSValue    *damageVal    = [NSValue value:&damage
                               withObjCType:@encode(int *)];

  NSDictionary *damageData = @{@"amount": damageVal, @"entity": otherEntity};
  [[NSNotificationCenter defaultCenter] postNotificationName:@"takeDamage"
                                                      object:self
                                                    userInfo:damageData];

  NSDictionary *destroyData = @{@"entity": entity};
  [[NSNotificationCenter defaultCenter] postNotificationName:@"destroyEntity"
                                                      object:self
                                                    userInfo:destroyData];
}

@end