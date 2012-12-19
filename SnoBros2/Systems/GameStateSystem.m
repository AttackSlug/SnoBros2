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
    state_ = @"Adjusting";
    previousState_ = nil;
  }
  return self;
}



- (void)togglePause {
  if ([state_ isEqualToString:@"Paused"]) {
    NSString *temp = state_;
    state_ = previousState_;
    previousState_ = temp;
  } else {
    previousState_ = state_;
    state_ = @"Paused";
  }
  [self throwStateChangeEvent];
}



- (void)nextPhase {
  previousState_ = state_;
  state_ = @"Playing";
  [self throwStateChangeEvent];
}



- (void)throwStateChangeEvent {
  NSDictionary *stateData = @{@"previousState": previousState_, @"currentState": state_};
  [[NSNotificationCenter defaultCenter] postNotificationName:@"stateChange"
                                                      object:self
                                                    userInfo:stateData];
}



- (void)update {
  
}



- (void)activate {
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(togglePause)
                                               name:@"togglePause"
                                             object:nil];
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(nextPhase)
                                               name:@"nextPhase"
                                             object:nil];
}



- (void)deactivate {
  [[NSNotificationCenter defaultCenter] removeObserver:self
                                                  name:@"togglePause"
                                                object:nil];
  [[NSNotificationCenter defaultCenter] removeObserver:self
                                                  name:@"nextPhase"
                                                object:nil];
}

@end
