//
//  AppDelegate.m
//  Component
//
//  Created by Chad Jablonski on 11/1/12.
//  Copyright (c) 2012 Attack Slug. All rights reserved.
//

#import "AppDelegate.h"
#import "GameViewController.h"

#import "MainMenuViewController.h"

#import "TestFlight.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

  #if DEBUG
  if (getenv("RUNNING_TESTS")) { return YES; }
  #endif

  [self setupTestflight];

  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(showGameView)
                                               name:@"showGameView"
                                             object:nil];
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(showMenuView)
                                               name:@"showMenuView"
                                             object:nil];


  self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
  self.window.backgroundColor = [UIColor whiteColor];

  [self showMenuView];

  [self.window makeKeyAndVisible];
  return YES;
}


- (void)setupTestflight {
  [TestFlight takeOff:[NSString stringWithUTF8String:TESTFLIGHT_TOKEN]];
  #define TESTING 1
  #ifdef TESTING
    [TestFlight setDeviceIdentifier:[[UIDevice currentDevice] uniqueIdentifier]];
  #endif
}


- (void)showGameView {
  self.window.rootViewController = [[GameViewController alloc] init];
  [TestFlight passCheckpoint:@"Start Game"];
}


- (void)showMenuView {
  self.window.rootViewController = [[MainMenuViewController alloc]
                                    initWithNibName:@"MainMenu" bundle:nil];
}


- (void)applicationWillResignActive:(UIApplication *)application {
  // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
  // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}



- (void)applicationDidEnterBackground:(UIApplication *)application {
  // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
  // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}



- (void)applicationWillEnterForeground:(UIApplication *)application {
  // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}



- (void)applicationDidBecomeActive:(UIApplication *)application {
  // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}



- (void)applicationWillTerminate:(UIApplication *)application {
  // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end