//
//  AppDelegate.h
//  Component
//
//  Created by Cjab on 11/1/12.
//  Copyright (c) 2012 Cjab. All rights reserved.
//

#import <GLKit/GLKit.h>
#import <UIKit/UIKit.h>
#import "Scene.h"

@interface AppDelegate : UIResponder<UIApplicationDelegate, GLKViewControllerDelegate, GLKViewDelegate> {
  Scene *currentScene_;
}

@property (strong, nonatomic) UIWindow *window;

@end