//
//  GameSystem.h
//  SnoBros2
//
//  Created by Tanoy Sinha on 12/19/12.
//  Copyright (c) 2012 Attack Slug. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol GameSystem <NSObject>

@required
- (void)activate;
- (void)deactivate;
- (void)update;

@end
