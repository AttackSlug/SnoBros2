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

const static float TIMESTEP_INTERVAL = 1.f / 60.f;
const static int   MAX_STEPS         = 5;

@interface EventQueue : NSObject {
  EntityManager         *entityManager_;
  Camera              *camera_;
  NSMutableArray        *events_;
  NSTimeInterval       timestepAccumulator_;
  NSTimeInterval       timestepAccumulatorRatio_;
  NSTimeInterval const timestepInterval_;
}

@property (nonatomic) Camera *camera;

- (id)initWithEntityManager:(EntityManager*)entityManager;

- (void)addEvent:(Event*)e;
- (void)addOneFingerTapEvent:(UITapGestureRecognizer*)gr;
- (void)addTwoFingerTapEvent:(UITapGestureRecognizer*)gr;
- (void)executeEvents;
- (void)clearEvents;

- (void)update:(NSTimeInterval)elapsedTime;
- (void)step;
- (void)render;

- (Entity*)getEntityByID:(NSString*)uuid;
- (Entity*)getEntityByTag:(NSString*)tag;

@end
