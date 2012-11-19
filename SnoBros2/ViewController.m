//
//  ViewController.m
//  Component
//
//  Created by Cjab on 11/4/12.
//  Copyright (c) 2012 Cjab. All rights reserved.
//

#import "ViewController.h"

#import "Camera.h"
#import "Quadtree.h"
#import "Input.h"

@implementation ViewController

@synthesize quadtree = quadtree_;


- (void)viewDidLoad {
  [self setupGL];

  eventQueue_    = [[EventQueue alloc] init];
  inputHandler_  = [[Input alloc] initWithView:self.view];
  
  button_ = [self setupButton];

  UIGestureRecognizer *swipe =
    [[UISwipeGestureRecognizer alloc] initWithTarget:self
                                              action:@selector(gotswipe:)];
  
  [self.view addGestureRecognizer:swipe];
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

  glDepthFunc(GL_GREATER);
  glEnable(GL_DEPTH_TEST);
}



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
  return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}



- (void)update {
  [eventQueue_ update:[self timeSinceLastUpdate]];
  [eventQueue_ executeEvents];
  [eventQueue_ clearEvents];
}



- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
  for (UITouch *touch in touches) {
    //[inputHandler_ addTouch:touch];
  }
}



- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
}



- (UIButton *)setupButton {
  UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
  button.frame = CGRectMake(10, 10, 100, 100);
  [inputHandler_ addButtonGestureRecognizer:button];
  [self.view addSubview:button];
  
  return button;
}



@end
