//
//  LeftPlayer.h
//  Component
//
//  Created by Chad Jablonski on 11/7/12.
//  Copyright (c) 2012 Attack Slug. All rights reserved.
//

#import "Behavior.h"

@class Entity;

@interface LeftPlayer : Behavior

- (id)initWithEntity:(Entity *)entity;
- (id)initWithEntity:(Entity *)entity dictionary:(NSDictionary *)data;

- (void)walkTo:(NSNotification *)notification;

@end