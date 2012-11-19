//
//  Input.m
//  Component
//
//  Created by Cjab on 11/5/12.
//  Copyright (c) 2012 Cjab. All rights reserved.
//

#import "Input.h"
#import "Entity.h"
#import "Behavior.h"

@implementation Input

- (id) initWithView:(UIView *)view AndEventQueue:(EventQueue *)queue {
  self = [super init];
  if (self) {
    oneFingerTap_ = [[UITapGestureRecognizer alloc] initWithTarget:queue
                                                            action:@selector(addOneFingerTapEvent:)];
    oneFingerTap_.numberOfTapsRequired = 1;
    oneFingerTap_.numberOfTouchesRequired = 1;
    [view addGestureRecognizer:oneFingerTap_];
    
    twoFingerTap_ = [[UITapGestureRecognizer alloc] initWithTarget:queue
                                                            action:@selector(addTwoFingerTapEvent:)];
    twoFingerTap_.numberOfTapsRequired = 1;
    twoFingerTap_.numberOfTouchesRequired = 2;
    [view addGestureRecognizer:twoFingerTap_];
  }
  return self;
}



@end