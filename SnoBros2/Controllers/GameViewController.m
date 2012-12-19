//
//  ViewController.m
//  Component
//
//  Created by Chad Jablonski on 11/4/12.
//  Copyright (c) 2012 Attack Slug. All rights reserved.
//

#import "GameViewController.h"

#import "Game.h"
#import "FPSMeter.h"

@implementation GameViewController

- (void)viewDidLoad {
  [self setupGL];
  game_         = [[Game alloc] initWithView:self.view];
}



- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect {
  glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
  [game_ render];
}



- (void)setupGL {
  EAGLContext *context = [[EAGLContext alloc]
                          initWithAPI:kEAGLRenderingAPIOpenGLES2];
  [EAGLContext setCurrentContext:context];


  GLKView *view = [[GLKView alloc]
                   initWithFrame:[[UIScreen mainScreen]bounds]
                   context:context];
  view.context  = context;
  view.backgroundColor = [UIColor blueColor];

  self.view     = view;
  view.drawableDepthFormat = GLKViewDrawableDepthFormat24;
}



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
  return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}



- (void)update {
  [game_ update:[self timeSinceLastUpdate]];
}

@end