//
//  UIManager.h
//  SnoBros2
//
//  Created by Tanoy Sinha on 12/17/12.
//  Copyright (c) 2012 Attack Slug. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIManager : NSObject {
  NSMutableDictionary *subViews_;
  UIView *rootView_;
  int viewCount_;
}

- (id)initWithView:(UIView *)view;
- (void)addUIElement:(UIView *)view withName:(NSString *)name;
- (UIView *)subViewWithName:(NSString *)name;
- (void)updateFPSWithTime:(NSTimeInterval)timeSinceLastUpdate;


@end
