//
//  AppDelegate.m
//  Component
//
//  Created by Cjab on 11/1/12.
//  Copyright (c) 2012 Cjab. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "Entity.h"
#import "Component.h"
#import "Transform.h"
#import "Physics.h"
#import "Renderer.h"
#import "Input.h"

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application
didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  [self setupGL];
  currentScene_ = [[Scene alloc] init];
  return YES;
}



- (UIResponder *)nextResponder {
  return currentScene_;
}



- (void)setupGL {
  EAGLContext *context = [[EAGLContext alloc]
                          initWithAPI:kEAGLRenderingAPIOpenGLES2];
  [EAGLContext setCurrentContext:context];
  glEnable(GL_DEPTH_TEST);

  GLKView *view = [[GLKView alloc]
                   initWithFrame:[[UIScreen mainScreen]bounds]
                   context:context];
  view.delegate = self;
  view.context  = context;

  ViewController *controller = [[ViewController alloc] init];
  controller.delegate = self;
  controller.view     = view;

  self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
  self.window.rootViewController = controller;
  [self.window makeKeyAndVisible];

  glClearColor(0.7f, 0.7f, 0.7f, 1.0f);
}



- (void)glkViewControllerUpdate:(GLKViewController *)controller {
  //NSTimeInterval elapsedTime = controller.timeSinceLastUpdate;
  //if (elapsedTime > 0.001) {
  //  [map_    update:elapsedTime];
  //  [player_ update:elapsedTime];
  //}
  [currentScene_ update];
}



- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect {
  glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
  [currentScene_ render];
}



- (void)applicationWillResignActive:(UIApplication *)application
{
  // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
  // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
  // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
  // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
  // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
  // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
  // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
