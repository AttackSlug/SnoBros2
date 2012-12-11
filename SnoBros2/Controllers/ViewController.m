//
//  ViewController.m
//  Component
//
//  Created by Chad Jablonski on 11/4/12.
//  Copyright (c) 2012 Attack Slug. All rights reserved.
//

#import "ViewController.h"

#import "InputSystem.h"
#import "Game.h"
#import "FPSMeter.h"

@implementation ViewController

- (void)viewDidLoad {
  [self setupGL];

  game_         = [[Game alloc] init];
  inputSystem_  = [[InputSystem alloc] initWithView:self.view
                                      entityManager:game_.entityManager
                                    selectionSystem:game_.selectionSystem
                                             camera:game_.camera];
  fpsMeter_     = [[FPSMeter alloc] initWithFrame:CGRectMake(2, 2, 20, 20) refreshRate:6];
  [self.view addSubview:fpsMeter_];
}



- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect {
  glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
  [fpsMeter_ updateWithElaspedTime:[self timeSinceLastUpdate]];
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