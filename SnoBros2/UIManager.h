//
//  UIManager.h
//  SnoBros2
//
//  Created by Tanoy Sinha on 12/17/12.
//  Copyright (c) 2012 Attack Slug. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIManager : NSObject {
  NSMutableArray *UIElements_;
}

- (id)initWithView:(UIView *)view;
- (void)update;


@end
