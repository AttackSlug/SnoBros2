//
//  Projectile.h
//  SnoBros2
//
//  Created by Cjab on 11/25/12.
//  Copyright (c) 2012 Cjab. All rights reserved.
//

#import "Component.h"

@class Entity;

@interface Projectile : Component {
  Entity *target_;
}

@property (nonatomic) Entity *target;

- (id)initWithEntity:(Entity *)entity;
- (id)initWithEntity:(Entity *)entity dictionary:(NSDictionary *)data;

- (void)update;

@end