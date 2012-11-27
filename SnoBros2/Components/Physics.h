//
//  Physics.h
//  Component
//
//  Created by Chad Jablonski on 11/1/12.
//  Copyright (c) 2012 Attack Slug. All rights reserved.
//

#import <GLKit/GLKit.h>
#import "Component.h"

@class Entity;

@interface Physics : Component {
  GLKVector2 velocity_;
}

@property (nonatomic) GLKVector2 velocity;

- (id)initWithEntity:(Entity *)entity;
- (id)initWithEntity:(Entity *)entity dictionary:(NSDictionary *)data;

- (void)update;

@end