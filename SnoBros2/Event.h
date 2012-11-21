//
//  Event.h
//  Component
//
//  Created by Cjab on 11/7/12.
//  Copyright (c) 2012 Cjab. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Event : NSObject {
  NSString  *type_;
  NSString  *target_;
  id         payload_;
}

@property (nonatomic, readonly) NSString  *type;
@property (nonatomic, readonly) NSString  *target;
@property (nonatomic, readonly) id         payload;

- (id)initWithType:(NSString *)type
            target:(NSString *)target
           payload:(id)payload;

@end