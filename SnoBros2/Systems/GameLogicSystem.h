//
//  GameLogicSystem.h
//  SnoBros2
//
//  Created by Tanoy Sinha on 12/17/12.
//  Copyright (c) 2012 Attack Slug. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "GameSystem.h"

@interface GameLogicSystem : NSObject <GameSystem> {
  float elapsedTime_;
}

- (id)init;
- (void)update;

@end
