//
//  Component.m
//  Component
//
//  Created by Cjab on 11/1/12.
//  Copyright (c) 2012 Cjab. All rights reserved.
//

#import "Component.h"
#import "Entity.h"
#import "Event.h"

@implementation Component

- (id)initWithEntity:(Entity *)entity {
  self = [super init];
  if (self) {
    entity_ = entity;
  }
  return self;
}



- (void)update {
}



- (void)sendEvent:(Event *)event {
  [entity_ sendEvent:event];
}



- (void)receiveEvent:(id)event {
  // Do something!
}

@end