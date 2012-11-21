//
//  Event.m
//  Component
//
//  Created by Cjab on 11/7/12.
//  Copyright (c) 2012 Cjab. All rights reserved.
//

#import "Event.h"

@implementation Event

@synthesize type    = type_;
@synthesize target  = target_;
@synthesize payload = payload_;

- (id)initWithType:(NSString *)type
            target:(NSString *)target
           payload:(id)payload {
  self = [super init];
  if (self) {
    type_    = type;
    target_  = target;
    payload_ = payload;
  }
  return self;
}

@end