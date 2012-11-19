//
//  ViewController.h
//  Component
//
//  Created by Cjab on 11/4/12.
//  Copyright (c) 2012 Cjab. All rights reserved.
//

#import <GLKit/GLKit.h>

@class Quadtree;
@class Input;
#import "Event.h"
#import "EventQueue.h"

@interface ViewController : GLKViewController {
  EventQueue          *eventQueue_;
  Quadtree            *quadtree_;
  Input               *inputHandler_;
  UIButton            *button_;
}

@property Quadtree            *quadtree;

- (void)update;
- (void)setupGL;
- (UIButton*)setupButton;

@end