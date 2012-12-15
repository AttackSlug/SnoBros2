//
//  DamageSystem.m
//  SnoBros2
//
//  Created by Tanoy Sinha on 12/14/12.
//  Copyright (c) 2012 Attack Slug. All rights reserved.
//

#import "DamageSystem.h"
#import "Entity.h"
#import "Health.h"

@implementation DamageSystem

- (id)initWithEntityManager:(EntityManager *)entityManager {
  self = [super init];
  if (self) {
    entityManager_ = entityManager;
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(takeDamage:)
                                                 name:@"takeDamage"
                                               object:nil];
  }
  return self;
}



- (void)takeDamage:(NSNotification *)notification {
  int amount;
  [[notification userInfo][@"amount"] getValue:&amount];
  Entity *entity = [notification userInfo][@"entity"];
  Health *health = [entity getComponentByString:@"Health"];
  [health damage:amount];
}

@end
