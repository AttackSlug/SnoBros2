//
//  Behavior.h
//  Component
//
//  Created by Chad Jablonski on 11/5/12.
//  Copyright (c) 2012 Attack Slug. All rights reserved.
//

#import <GLKit/GLKit.h>
#import "Component.h"

@class Entity;

@interface Behavior : Component {
  GLKVector2      target_;
  GLKVector2      direction_;
}

- (id)initWithEntity:(Entity *)entity;
- (id)initWithEntity:(Entity *)entity dictionary:(NSDictionary *)data;

- (void)update;

@end