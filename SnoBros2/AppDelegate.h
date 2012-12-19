//
//  AppDelegate.h
//  Component
//
//  Created by Chad Jablonski on 11/1/12.
//  Copyright (c) 2012 Attack Slug. All rights reserved.
//

#import <GLKit/GLKit.h>
#import <UIKit/UIKit.h>

@class GameViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) GameViewController *gameViewController;

@end