//
//  Physics.m
//  Component
//
//  Created by Cjab on 11/1/12.
//  Copyright (c) 2012 Cjab. All rights reserved.
//

#import "Entity.h"
#import "Physics.h"
#import "Transform.h"

@implementation Physics


- (id)initWithEntity:(Entity *)entity {
  return [super initWithEntity:entity];
}



- (void)update {
  [entity_.transform translate:velocity_];
}

@end