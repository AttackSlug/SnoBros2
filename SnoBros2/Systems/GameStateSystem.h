//
//  GameStateSystem.h
//  SnoBros2
//
//  Created by Tanoy Sinha on 12/17/12.
//  Copyright (c) 2012 Attack Slug. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "GameSystem.h"

@interface GameStateSystem : NSObject <GameSystem> {
  NSString *state_;
  NSString *previousState_;
}

@property (nonatomic, readonly) NSString *state;

- (id)init;
- (void)togglePause;
- (void)nextPhase;
- (void)throwStateChangeEvent;

@end
