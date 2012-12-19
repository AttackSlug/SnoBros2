//
//  DamageSystem.h
//  SnoBros2
//
//  Created by Tanoy Sinha on 12/14/12.
//  Copyright (c) 2012 Attack Slug. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "GameSystem.h"

@class EntityManager;

@interface DamageSystem : NSObject <GameSystem> {
  EntityManager *entityManager_;
}

- (id)initWithEntityManager:(EntityManager *)entityManager;
- (void)takeDamage:(NSNotification *)notification;

@end
