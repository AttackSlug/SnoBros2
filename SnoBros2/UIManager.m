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
    UIElements_ = [[NSMutableArray alloc] init];
    
    FPSMeter *fpsMeter = [[FPSMeter alloc] initWithFrame:CGRectMake(2, 2, 20, 20) refreshRate:6];
    fpsMeter.tag = 1;
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button setFrame:CGRectMake(22, 2, 20, 20)];
    button.tag = 2;
    
    [UIElements_ addObject:fpsMeter];
    [UIElements_ addObject:button];
    [view addSubview:fpsMeter];
    [view addSubview:button];
  }
  return self;
}



- (void)update {
  
}

@end
