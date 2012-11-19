//
//  ViewController.h
//  Component
//
//  Created by Cjab on 11/4/12.
//  Copyright (c) 2012 Cjab. All rights reserved.
//

#import <GLKit/GLKit.h>

@class Game;
@class Input;

@interface ViewController : GLKViewController {
  Game          *game_;
  Input               *inputHandler_;
}

- (void)update;
- (void)setupGL;

@end