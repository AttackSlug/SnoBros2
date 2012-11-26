//
//  StandardCollider.h
//  SnoBros2
//
//  Created by Chad Jablonski on 11/25/12.
//  Copyright (c) 2012 Attack Slug. All rights reserved.
//

#import <GLKit/GLKit.h>

#import "Component.h"

@interface StandardCollider : Component

- (id)initWithEntity:(Entity *)entity;
- (id)initWithEntity:(Entity *)entity dictionary:(NSDictionary *)data;

- (void)collidedWith:(NSNotification *)notification;
- (void)resolveCollisionWith:(Entity *)otherEntity;
- (GLKVector2)intersectionWith:(Entity *)other;

@end