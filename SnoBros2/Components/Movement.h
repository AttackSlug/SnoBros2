//
//  Movement.h
//  SnoBros2
//
//  Created by Chad Jablonski on 12/7/12.
//  Copyright (c) 2012 Attack Slug. All rights reserved.
//

#import <GLKit/GLKit.h>

#import "Component.h"

#define DEFAULT_SPEED 4

@interface Movement : Component {
  GLKVector2 target_;
  int        speed_;
}

@property (nonatomic) GLKVector2 target;
@property (nonatomic) int        speed;

- (id)initWithEntity:(Entity *)entity;
- (id)initWithEntity:(Entity *)entity dictionary:(NSDictionary *)data;

@end