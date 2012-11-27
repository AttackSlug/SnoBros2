//
//  Attack.h
//  SnoBros2
//
//  Created by Chad Jablonski on 11/25/12.
//  Copyright (c) 2012 Attack Slug. All rights reserved.
//

#import "Component.h"

@class Entity;

@interface Attack : Component

- (id)initWithEntity:(Entity *)entity;
- (id)initWithEntity:(Entity *)entity dictionary:(NSDictionary *)data;

- (void)fireAt:(Entity *)entity;

@end