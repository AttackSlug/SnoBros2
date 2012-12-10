//
//  Attack.h
//  SnoBros2
//
//  Created by Chad Jablonski on 11/25/12.
//  Copyright (c) 2012 Attack Slug. All rights reserved.
//

#import <GLKit/GLKit.h>

#import "Component.h"

@class Entity;

@interface Attack : Component {
  float range_;
  float rate_;
  NSTimeInterval lastFired_;
}

@property (nonatomic) float range;

- (id)initWithEntity:(Entity *)entity;
- (id)initWithEntity:(Entity *)entity dictionary:(NSDictionary *)data;

- (void)fireAt:(GLKVector2)target;

@end