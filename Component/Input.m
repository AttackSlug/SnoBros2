//
//  Input.m
//  Component
//
//  Created by Cjab on 11/5/12.
//  Copyright (c) 2012 Cjab. All rights reserved.
//

#import "Input.h"
#import "Entity.h"

@implementation Input


- (id)initWithEntity:(Entity *)entity behavior:(Behavior *)behavior {
  self = [super init];
  if (self) {
    entity_   = entity;
    behavior_ = behavior;
  }
  return self;
}



- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
  for (UITouch *touch in touches) {
    CGPoint pt =[touch locationInView:touch.view];
    [behavior_ throwAt:GLKVector2Make(pt.x, pt.y)];
  }
}



- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
  for (UITouch *touch in touches) {
    CGPoint pt =[touch locationInView:touch.view];
    [behavior_ walkTo:GLKVector2Make(pt.x, pt.y)];
  }
}


@end