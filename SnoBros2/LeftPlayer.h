//
//  LeftPlayer.h
//  Component
//
//  Created by Cjab on 11/7/12.
//  Copyright (c) 2012 Cjab. All rights reserved.
//

#import "Behavior.h"

@class Entity;

@interface LeftPlayer : Behavior

- (id)initWithEntity:(Entity *)entity;
- (void)walkTo:(GLKVector2)target;

@end