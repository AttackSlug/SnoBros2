//
//  Input.h
//  Component
//
//  Created by Cjab on 11/5/12.
//  Copyright (c) 2012 Cjab. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Input : NSObject {
  NSMutableArray *touches_;
}

- (void)clearTouches;
- (void)addTouch:(UITouch *) touch;
- (void)executeTouches:(NSArray *) entities;

@end
