//
//  GameStateSystem.m
//  SnoBros2
//
//  Created by Tanoy Sinha on 12/17/12.
//  Copyright (c) 2012 Attack Slug. All rights reserved.
//

#import "GameStateSystem.h"

@implementation GameStateSystem

@synthesize state = state_;

- (id)init {
  self = [super init];
  if (self) {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(togglePause)
                                                 name:@"togglePause"
                                               object:nil];
    state_ = @"Unpaused";
  }
  return self;
}



- (void)togglePause {
  state_ = [state_ isEqualToString:@"Paused"] ? @"Unpaused" : @"Paused";
}

@end
