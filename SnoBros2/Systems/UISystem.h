//
//  UISystem.h
//  SnoBros2
//
//  Created by Tanoy Sinha on 12/17/12.
//  Copyright (c) 2012 Attack Slug. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "GameSystem.h"

@class UIManager;

@interface UISystem : NSObject <GameSystem> {
  UIManager *UIManager_;
}

- (id)initWithUIManager:(UIManager *)UIManager;

@end
