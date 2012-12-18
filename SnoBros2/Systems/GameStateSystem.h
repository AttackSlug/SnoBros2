//
//  GameStateSystem.h
//  SnoBros2
//
//  Created by Tanoy Sinha on 12/17/12.
//  Copyright (c) 2012 Attack Slug. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GameStateSystem : NSObject {
  NSString *state_;
  NSString *prePauseState_;
}

@property (nonatomic, readonly) NSString *state;

- (id)init;
- (void)togglePause;
- (void)nextPhase;

@end
