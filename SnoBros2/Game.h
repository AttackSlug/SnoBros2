//
//  EventQueue.h
//  SnoBros2
//
//  Created by Tanoy Sinha on 11/18/12.
//  Copyright (c) 2012 Cjab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Event.h"
#import "EntityManager.h"

@class Camera;
@class EventManager;

const static float TIMESTEP_INTERVAL = 1.f / 60.f;
const static int   MAX_STEPS         = 5;

@interface Game : NSObject {
  EntityManager         *entityManager_;
  Camera                *camera_;
  EventManager          *eventManager_;
  NSTimeInterval        timestepAccumulator_;
  NSTimeInterval        timestepAccumulatorRatio_;
  NSTimeInterval const  timestepInterval_;
}

@property (nonatomic) Camera        *camera;
@property (nonatomic) EventManager  *eventManager;

- (void)update:(NSTimeInterval)elapsedTime;
- (void)step;
- (void)render;

@end
