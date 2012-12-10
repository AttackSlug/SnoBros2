//
//  ProjectileSystem.m
//  SnoBros2
//
//  Created by Cjab on 12/10/12.
//  Copyright (c) 2012 Attack Slug. All rights reserved.
//

#import "ProjectileSystem.h"

#import "Entity.h"

@implementation ProjectileSystem

- (id)init {
  self = [super init];
  if (self) {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleArrivedAtTarget:)
                                                 name:@"arrivedAtTarget"
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

@end