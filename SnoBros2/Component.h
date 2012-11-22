//
//  Component.h
//  Component
//
//  Created by Cjab on 11/1/12.
//  Copyright (c) 2012 Cjab. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Entity;
@class Event;

@interface Component : NSObject {
  Entity *entity_;
}

- (id)initWithEntity:(Entity *)entity;
- (id)initWithEntity:(Entity *)entity dictionary:(NSDictionary *)data;

- (void)update;

- (void)sendEvent:(Event *)event;
- (void)receiveEvent:(Event *)event;

@end