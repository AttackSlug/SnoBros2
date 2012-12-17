//
//  UIManager.m
//  SnoBros2
//
//  Created by Tanoy Sinha on 12/17/12.
//  Copyright (c) 2012 Attack Slug. All rights reserved.
//

#import "UIManager.h"
#import "FPSMeter.h"

@implementation UIManager

- (id)initWithView:(UIView *)view {
  self = [super init];
  if (self) {
    rootView_ = view;
    subViews_ = [[NSMutableDictionary alloc] init];
    viewCount_ = 0;
    
    FPSMeter *fpsMeter = [[FPSMeter alloc] initWithFrame:CGRectMake(2, 2, 20, 20) refreshRate:6];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button setFrame:CGRectMake(22, 2, 20, 20)];
    
    [self addUIElement:fpsMeter withName:@"FPSMeter"];
    [self addUIElement:button withName:@"button"];
  }
  return self;
}



- (void)addUIElement:(UIView *)view withName:(NSString *)name {
  viewCount_++;
  view.tag = viewCount_;
  subViews_[name] = [NSNumber numberWithInt:viewCount_];
  [rootView_ addSubview:view];
}



- (UIView *)subViewWithName:(NSString *)name {
  return [rootView_ viewWithTag:[subViews_[name] intValue]];
}



- (void)updateFPSWithTime:(NSTimeInterval)timeSinceLastUpdate {
  [((FPSMeter *)[self subViewWithName:@"FPSMeter"]) updateWithElaspedTime:timeSinceLastUpdate];
}

@end
