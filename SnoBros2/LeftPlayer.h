//
//  LeftPlayer.h
//  Component
//
//  Created by Cjab on 11/7/12.
//  Copyright (c) 2012 Cjab. All rights reserved.
//

#import "Behavior.h"

@class Physics;
@class Transform;
@class Entity;

@interface LeftPlayer : Behavior

- (id)initWithEntity:(Entity *)entity;
- (void)walkTo:(NSValue*)message;

@end
