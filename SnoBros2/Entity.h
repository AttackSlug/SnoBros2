//
//  Entity.h
//  Component
//
//  Created by Cjab on 11/1/12.
//  Copyright (c) 2012 Cjab. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Transform;
@class Renderer;
@class Physics;
@class Input;
@class Camera;
@class Behavior;
@class Collision;
@class Selectable;
@class Sprite;
@class EventManager;
@class Event;

@interface Entity : NSObject {
  NSString     *tag_;
  NSString     *uuid_;
  Sprite       *sprite_;

  Transform    *transform_;
  Renderer     *renderer_;
  Physics      *physics_;
  Behavior     *behavior_;
  Collision    *collision_;
  Selectable   *selectable_;

  EventManager *eventManager_;
}

@property (nonatomic) NSString    *tag;
@property (nonatomic) NSString    *uuid;
@property (nonatomic) Sprite      *sprite;

@property (nonatomic) Transform   *transform;
@property (nonatomic) Renderer    *renderer;
@property (nonatomic) Physics     *physics;
@property (nonatomic) Behavior    *behavior;
@property (nonatomic) Collision   *collision;
@property (nonatomic) Selectable  *selectable;

- (id)init;
- (id)initWithTag:(NSString *)tag;
- (id)initWithTag:(NSString *)tag eventManager:(EventManager *)eventManager;

- (void)update;
- (void)renderWithCamera:(Camera*)camera interpolationRatio:(double)ratio;

- (void)sendEvent:(Event *)event;
- (void)receiveEvent:(Event *)event;

@end
