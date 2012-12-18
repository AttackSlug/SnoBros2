//
//  GameLogicSystem.m
//  SnoBros2
//
//  Created by Tanoy Sinha on 12/17/12.
//  Copyright (c) 2012 Attack Slug. All rights reserved.
//

#import "GameLogicSystem.h"

@implementation GameLogicSystem

- (id)init {
  self = [super init];
  if (self) {
    elapsedTime_ = 0;
  }
  return self;
}



- (void)update {
  if (elapsedTime_ > 15 && elapsedTime_ < 31) {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"nextPhase"
                                                        object:self
                                                      userInfo:nil];
    elapsedTime_ += 100;
    NSLog(@"Fired");
  } else {
    elapsedTime_ += 1 / 60.f;
  }
}

@end
