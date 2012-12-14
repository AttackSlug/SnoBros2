//
//  Float.h
//  SnoBros2
//
//  Created by Chad Jablonski on 11/27/12.
//  Copyright (c) 2012 Attack Slug. All rights reserved.
//

#define FLOAT_K 0.000001f

#define FLOAT_COMPARE(XX, YY) \
  ((fabs(XX - YY) < FLOAT_K * FLT_EPSILON * fabs(XX + YY) ||  \
      fabs(XX - YY) < FLT_MIN) ? 0 : ((XX < YY) ? -1 : 1))

#define FLOAT_LESS_THAN(XX, YY) \
  ((FLOAT_COMPARE(XX, YY) < 0) ? YES : NO)

#define FLOAT_LESS_THAN_OR_EQUAL(XX, YY) \
  ((FLOAT_COMPARE(XX, YY) <= 0) ? YES : NO)

#define FLOAT_GREATER_THAN(XX, YY) \
  ((FLOAT_COMPARE(XX, YY) > 0) ? YES : NO)

#define FLOAT_GREATER_THAN_OR_EQUAL(XX, YY) \
  ((FLOAT_COMPARE(XX, YY) >= 0) ? YES : NO)

#define FLOAT_EQUAL(XX, YY) \
  ((FLOAT_COMPARE(XX, YY) == 0) ? YES : NO)