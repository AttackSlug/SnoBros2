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

- (id)init {
  self = [super init];
  if (self) {
    touches_ = [[NSMutableArray alloc] initWithCapacity:0];
  }
  return self;
}



- (void)clearTouches {
  [touches_ removeAllObjects];
}



- (void)addTouch:(UITouch *)touch {
  [touches_ addObject:touch];
}



- (void)executeTouches:(NSMutableArray *)entities { 
  for (UITouch *touch in touches_) {
    CGPoint p = [touch locationInView:touch.view];
    for (Entity *e in entities) {
      [e.behavior walkTo:GLKVector2Make(p.x, p.y)];
    }
  }
}

@end