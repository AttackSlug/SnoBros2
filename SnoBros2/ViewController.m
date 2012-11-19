//
//  ViewController.m
//  Component
//
//  Created by Cjab on 11/4/12.
//  Copyright (c) 2012 Cjab. All rights reserved.
//

#import "ViewController.h"

#import "Input.h"
#import "EventQueue.h"

@implementation ViewController

- (void)viewDidLoad {
  [self setupGL];

  eventQueue_    = [[EventQueue alloc] init];
  inputHandler_  = [[Input alloc] initWithView:self.view eventQueue:eventQueue_];
}



- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect {
  glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
  [eventQueue_ render];
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

  glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
  glCullFace(GL_FRONT);
  glDepthFunc(GL_LEQUAL);

  glEnable(GL_DEPTH_TEST);
  glEnable(GL_BLEND);
  glEnable(GL_CULL_FACE);
}



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
  return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}



- (void)update {
  [eventQueue_ update:[self timeSinceLastUpdate]];
}

@end
