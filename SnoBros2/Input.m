//
//  Input.m
//  Component
//
//  Created by Cjab on 11/5/12.
//  Copyright (c) 2012 Cjab. All rights reserved.
//

#import "Input.h"
#import "Entity.h"
#import "Behavior.h"

@implementation Input

- (id)init {
  self = [super init];
  if (self) {
    touches_ = [[NSMutableArray alloc] initWithCapacity:0];
  }
  return self;
}



- (id)initWithView:(UIView *)view {
  self = [super init];
  if (self) {
    touches_ = [[NSMutableArray alloc] initWithCapacity:0];
    oneFingerTap_ = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                            action:@selector(throwSingleTapEvent:)];
    oneFingerTap_.numberOfTapsRequired = 1;
    oneFingerTap_.numberOfTouchesRequired = 1;
    [view addGestureRecognizer:oneFingerTap_];
    
    
    twoFingerTap_ = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                   action:@selector(throwDoubleTapEvent:)];
    twoFingerTap_.numberOfTapsRequired = 1;
    twoFingerTap_.numberOfTouchesRequired = 2;
    [view addGestureRecognizer:twoFingerTap_];
  }
  return self;
}



- (void)clearTouches {
  [touches_ removeAllObjects];
}



- (void)addTouch:(UITouch *)touch {
  [touches_ addObject:touch];
}



- (void)executeTouches:(NSArray *)entities {
  for (UITouch *touch in touches_) {
    CGPoint p = [touch locationInView:touch.view];
    for (Entity *e in entities) {
      [e.behavior walkTo:GLKVector2Make(p.x, p.y)];
    }
  }
}



- (void)addButtonGestureRecognizer:(UIButton *)button {
  oneFingerButtonTap_ = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                action:@selector(throwOneFingerButtonTap:)];
  oneFingerButtonTap_.numberOfTouchesRequired = 1;
  oneFingerButtonTap_.numberOfTapsRequired = 1;
  oneFingerButtonTap_.cancelsTouchesInView = YES;
  [button addGestureRecognizer:oneFingerButtonTap_];
}



- (void)throwDoubleTapEvent:(UITapGestureRecognizer *)gr {
  NSLog(@"TwoFingerTapEvent");
}



- (void)throwSingleTapEvent:(UITapGestureRecognizer *)gr {
  NSLog(@"OneFingerTapEvent");
}



- (void)throwOneFingerButtonTap:(UITapGestureRecognizer *)gr {
  NSLog(@"OneFingerButtonTapEvent");
}

@end