//
//  Float.h
//  SnoBros2
//
//  Created by Chad Jablonski on 11/27/12.
//  Copyright (c) 2012 Attack Slug. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Float : NSObject

+ (int)compare:(float)value1 to:(float)value2;

+ (bool)is:(float)value1 equalTo:(float)value2;
+ (bool)is:(float)value1 lessThan:(float)value2;
+ (bool)is:(float)value1 greaterThan:(float)value2;
+ (bool)is:(float)value1 lessThanOrEqualTo:(float)value2;
+ (bool)is:(float)value1 greaterThanOrEqualTo:(float)value2;

@end