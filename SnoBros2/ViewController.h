//
//  ViewController.h
//  Component
//
//  Created by Cjab on 11/4/12.
//  Copyright (c) 2012 Cjab. All rights reserved.
//

#import <GLKit/GLKit.h>
#import "Scene.h"

@interface ViewController : GLKViewController {
  Scene *currentScene_;
}

- (void)update;
- (void)setupGL;

@end
