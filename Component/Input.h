//
//  Input.h
//  Component
//
//  Created by Cjab on 11/5/12.
//  Copyright (c) 2012 Cjab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AI.h"

@class Entity;

@interface Input : UIResponder {
  Entity *entity_;
  AI     *ai_;
}

- (id)initWithEntity:(Entity *)entity ai:(AI *)ai;

@end
