//
//  Input.h
//  Component
//
//  Created by Cjab on 11/5/12.
//  Copyright (c) 2012 Cjab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EventQueue.h"

@interface Input : NSObject {
  UITapGestureRecognizer *oneFingerTap_;
  UITapGestureRecognizer *twoFingerTap_;
}

- (id)initWithView:(UIView*) view AndEventQueue:(EventQueue*) queue;

@end
