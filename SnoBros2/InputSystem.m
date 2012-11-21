//
//  Input.m
//  Component
//
//  Created by Cjab on 11/5/12.
//  Copyright (c) 2012 Cjab. All rights reserved.
//

#import "InputSystem.h"
#import "EventManager.h"

@implementation InputSystem

- (id)initWithView:(UIView *)view
      eventManager:(EventManager *)eventManager {
  self = [super init];
  if (self) {
    oneFingerTap_ = [[UITapGestureRecognizer alloc] initWithTarget:eventManager
                                                            action:@selector(addOneFingerTapEvent:)];
    oneFingerTap_.numberOfTapsRequired = 1;
    oneFingerTap_.numberOfTouchesRequired = 1;
    [view addGestureRecognizer:oneFingerTap_];
    
    twoFingerTap_ = [[UITapGestureRecognizer alloc] initWithTarget:eventManager
                                                            action:@selector(addTwoFingerTapEvent:)];
    twoFingerTap_.numberOfTapsRequired = 1;
    twoFingerTap_.numberOfTouchesRequired = 2;
    [view addGestureRecognizer:twoFingerTap_];
    
    boxSelector_ = [[UIPanGestureRecognizer alloc] initWithTarget:eventManager
                                                           action:@selector(addBoxSelectorEvent:)];
    boxSelector_.minimumNumberOfTouches = 1;
    boxSelector_.maximumNumberOfTouches = 1;
    [view addGestureRecognizer:boxSelector_];
  }
  return self;
}

@end