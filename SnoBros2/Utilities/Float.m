//
//  Float.m
//  SnoBros2
//
//  Created by Cjab on 11/27/12.
//  Copyright (c) 2012 Attack Slug. All rights reserved.
//

#import "Float.h"

@implementation Float

const float K = 0.000001f;

+ (int)compare:(float)value1 to:(float)value2 {
  if (fabs(value1 - value2) < K * FLT_EPSILON * fabs(value1 + value2) ||
      fabs(value1 - value2) < FLT_MIN) {
    return  0;
  } else if (value1 < value2) {
    return -1;
  } else {
    return  1;
  }
}



+ (bool)is:(float)value1 equalTo:(float)value2 {
  return ![self compare:value1 to:value2];
}



+ (bool)is:(float)value1 lessThan:(float)value2 {
  return ([self compare:value1 to:value2] == -1);
}



+ (bool)is:(float)value1 greaterThan:(float)value2 {
  return ([self compare:value1 to:value2] == 1);
}



+ (bool)is:(float)value1 lessThanOrEqualTo:(float)value2 {
  return ([self is:value1 equalTo:value2] || [self is:value1 lessThan:value2]);
}



+ (bool)is:(float)value1 greaterThanOrEqualTo:(float)value2 {
  return ([self is:value1 equalTo:value2] || [self is:value1 greaterThan:value2]);
}

@end