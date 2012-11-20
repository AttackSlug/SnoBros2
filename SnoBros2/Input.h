//
//  Input.h
//  Component
//
//  Created by Cjab on 11/5/12.
//  Copyright (c) 2012 Cjab. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EventManager;

@interface Input : NSObject {
  UITapGestureRecognizer    *oneFingerTap_;
  UITapGestureRecognizer    *twoFingerTap_;
  UIPanGestureRecognizer    *boxSelector_;
}

- (id)initWithView:(UIView *)view
      eventManager:(EventManager *)eventManager;

@end
