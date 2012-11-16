//
//  Input.h
//  Component
//
//  Created by Cjab on 11/5/12.
//  Copyright (c) 2012 Cjab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Behavior.h"

@class Entity;

@interface Input : NSObject {
  NSMutableArray *touches_;
}

- (void)clearTouches;
- (void)addTouch:(UITouch*) touch;
- (void)executeTouches:(NSMutableArray*) entities;

@end
