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
  self = [super initWithEntity:entity];
  if (self) {
    NSString *name = [entity_.uuid stringByAppendingString:@"|collidedWith"];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(collidedWith:)
                                                 name:name
                                               object:nil];

  }
  return self;
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



- (void)collidedWith:(NSNotification *)notification {
  Entity *otherEntity = [notification userInfo][@"otherEntity"];

  if (otherEntity == target_) {
    target_ = nil;
    NSDictionary *data = @{@"entity": entity_};
    [[NSNotificationCenter defaultCenter] postNotificationName:@"destroyEntity"
                                                        object:self
                                                      userInfo:data];
  }
}

@end