//
//  ViewController.h
//  Component
//
//  Created by Chad Jablonski on 11/4/12.
//  Copyright (c) 2012 Attack Slug. All rights reserved.
//

#import <GLKit/GLKit.h>

@class Game;
@class FPSMeter;

@interface ViewController : GLKViewController {
  Game        *game_;
  FPSMeter    *fpsMeter_;
}

- (void)update;
- (void)setupGL;

@end