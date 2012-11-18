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
  UITapGestureRecognizer *oneFingerTap_;
  UITapGestureRecognizer *twoFingerTap_;
  UITapGestureRecognizer *oneFingerButtonTap_;
}

- (id)initWithView:(UIView*) view;

- (void)clearTouches;
- (void)addTouch:(UITouch *) touch;
- (void)executeTouches:(NSArray *) entities;

- (void)addButtonGestureRecognizer:(UIButton*)button;

- (void)throwOneFingerTap:(UITapGestureRecognizer*) gr;
- (void)throwTwoFingerTap:(UITapGestureRecognizer*) gr;
- (void)throwOneFingerButtonTap:(UITapGestureRecognizer*) gr;

@end
