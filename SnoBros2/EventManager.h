//
//  EventManager.h
//  SnoBros2
//
//  Created by Tanoy Sinha on 11/20/12.
//  Copyright (c) 2012 Cjab. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Camera;
@class EntityManager;
@class Event;
@class Entity;
@class Behavior;

@interface EventManager : NSObject {
  Camera          *camera_;
  EntityManager   *entityManager_;
  NSMutableArray  *eventQueue_;
}

- (id)initWithCamera:(Camera *)camera entityManager:(EntityManager *)entityManager;

- (void)addEvent:(Event*)e;
- (void)addOneFingerTapEvent:(UITapGestureRecognizer*)gr;
- (void)addTwoFingerTapEvent:(UITapGestureRecognizer*)gr;
- (void)executeEvents;
- (void)clearEvents;

@end
