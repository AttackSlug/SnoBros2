//
//  Input.m
//  Component
//
//  Created by Cjab on 11/5/12.
//  Copyright (c) 2012 Cjab. All rights reserved.
//

#import "Entity.h"
#import "Input.h"

@implementation Input


- (id)initWithEntity:(Entity *)entity {
  self = [super init];
  if (self) {
    entity_ = entity;
  }
  return self;
}



- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
  for (UITouch *touch in touches) {
    CGPoint pt =[touch locationInView:touch.view];
    //[entity_ walkTo:GLKVector2Make(pt.x, pt.y)];
    NSLog(@"Touched");
  }
}



- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
  for (UITouch *touch in touches) {
    CGPoint pt =[touch locationInView:touch.view];
    //[entity_ walkTo:GLKVector2Make(pt.x, pt.y)];
    NSLog(@"Moved");
  }
}


@end