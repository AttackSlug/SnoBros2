//
//  Behavior.m
//  Component
//
//  Created by Cjab on 11/5/12.
//  Copyright (c) 2012 Cjab. All rights reserved.
//

#import "Behavior.h"
#import "Entity.h"
#import "Transform.h"
#import "Physics.h"

@implementation Behavior

- (id)initWithEntity:(Entity *)entity {
  return [super initWithEntity:entity];
}



- (id)initWithEntity:(Entity *)entity dictionary:(NSDictionary *)data {
  return [self initWithEntity:entity];
}



- (void)update {
  Transform *transform  = [entity_ getComponentByString:@"Transform"];
  Physics   *physics    = [entity_ getComponentByString:@"Physics"];
  if (GLKVector2Distance(transform.position, target_) <= 10) {
    physics.velocity = GLKVector2Make(0.f, 0.f);
  }
}

@end