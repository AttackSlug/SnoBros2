//
//  Projectile.h
//  SnoBros2
//
//  Created by Chad Jablonski on 11/25/12.
//  Copyright (c) 2012 Attack Slug. All rights reserved.
//

#import <GLKit/GLKit.h>

#import "Component.h"

@class Entity;

@interface Projectile : Component {
  GLKVector2 target_;
  int        damage_;
}

@property (nonatomic) GLKVector2 target;
@property (nonatomic) int        damage;

- (id)initWithEntity:(Entity *)entity;
- (id)initWithEntity:(Entity *)entity dictionary:(NSDictionary *)data;

@end