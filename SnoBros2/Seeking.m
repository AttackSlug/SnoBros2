//
//  Seeking.m
//  SnoBros2
//
//  Created by Cjab on 11/25/12.
//  Copyright (c) 2012 Cjab. All rights reserved.
//

#import "Seeking.h"

#import "Entity.h"
#import "Transform.h"
#import "Physics.h"

@implementation Seeking

@synthesize target = target_;

- (id)initWithEntity:(Entity *)entity {
  return [super initWithEntity:entity];
}



- (id)initWithEntity:(Entity *)entity dictionary:(NSDictionary *)data {
  return [self initWithEntity:entity];
}



- (void)update {
  if (!target_) { return; }

  Transform *targetTransform = [target_ getComponentByString:@"Transform"];
  Transform *transform       = [entity_ getComponentByString:@"Transform"];
  Physics   *physics         = [entity_ getComponentByString:@"Physics"];

  GLKVector2 targetPosition  = targetTransform.position;
  GLKVector2 position        = transform.position;

  GLKVector2 direction = GLKVector2Normalize(GLKVector2Subtract(targetPosition,
                                                                position));
  physics.velocity = GLKVector2MultiplyScalar(direction, 10);
}

@end