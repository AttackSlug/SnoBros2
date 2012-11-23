//
//  Entity.h
//  Component
//
//  Created by Cjab on 11/1/12.
//  Copyright (c) 2012 Cjab. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Camera;

@class Component;

@class Sprite;
@class EventManager;
@class Event;

@interface Entity : NSObject {
  NSString     *tag_;
  NSString     *uuid_;
  Sprite       *sprite_;
  
  NSMutableDictionary *components_;

  EventManager *eventManager_;
}

@property (nonatomic) NSString    *tag;
@property (nonatomic) NSString    *uuid;
@property (nonatomic) Sprite      *sprite;

@property (nonatomic) NSMutableDictionary *components;

- (id)init;
- (id)initWithTag:(NSString *)tag;
- (id)initWithTag:(NSString *)tag eventManager:(EventManager *)eventManager;
- (id)initWithDictionary:(NSDictionary *)data;

- (void)update;
- (void)renderWithCamera:(Camera*)camera interpolationRatio:(double)ratio;

- (void)sendEvent:(Event *)event;
- (void)receiveEvent:(Event *)event;

- (id)getComponentByString:(NSString *)string;
- (void)setComponent:(Component *)component withString:(NSString *)string;
- (BOOL)hasComponent:(NSString *)string;

@end
