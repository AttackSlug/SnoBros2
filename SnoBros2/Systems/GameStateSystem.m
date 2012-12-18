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
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(nextPhase)
                                                 name:@"nextPhase"
                                               object:nil];
    state_ = @"Adjusting";
    prePauseState_ = nil;
  }
  return self;
}



- (void)togglePause {
  if ([state_ isEqualToString:@"Paused"]) {
    state_ = prePauseState_;
    prePauseState_ = nil;
  } else {
    prePauseState_ = state_;
    state_ = @"Paused";
  }
}



- (void)nextPhase {
  state_ = @"Playing";
}

@end
