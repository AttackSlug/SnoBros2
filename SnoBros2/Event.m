//
//  Event.m
//  Component
//
//  Created by Cjab on 11/7/12.
//  Copyright (c) 2012 Cjab. All rights reserved.
//

#import "Event.h"

@implementation Event

@synthesize entityID  = id_;
@synthesize func      = func_;
@synthesize payload   = payload_;

- (id)initWithID:(NSString *)uuid selector:(SEL)func payload:(NSValue *)payload{
  self = [super init];
  if (self) {
    id_ = uuid;
    func_ = func;
    payload_ = payload;
  }
  return self;
}

@end
