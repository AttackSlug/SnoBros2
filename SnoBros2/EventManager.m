//
//  EventManager.m
//  SnoBros2
//
//  Created by Tanoy Sinha on 11/20/12.
//  Copyright (c) 2012 Cjab. All rights reserved.
//

#import "EventManager.h"
#import "Camera.h"
#import "EntityManager.h"
#import "Event.h"
#import "Entity.h"
#import "Behavior.h"

@implementation EventManager

- (id)initWithCamera:(Camera *)camera entityManager:(EntityManager *)entityManager {
  self = [super init];
  if (self) {
    camera_         = camera;
    entityManager_  = entityManager;
    eventQueue_     = [[NSMutableArray alloc] initWithCapacity:0];
  }
  return self;
}



- (void)addEvent:(Event *)e {
  [eventQueue_ addObject:e];
}



- (void)addOneFingerTapEvent:(UITapGestureRecognizer *)gr {
  NSArray *players = [entityManager_ findByTag:@"player"];
  Entity *player = [players objectAtIndex:0];
  CGPoint p = [gr locationInView:gr.view];
  GLKVector2 pos = GLKVector2Add(GLKVector2Make(p.x, p.y), camera_.position);
  
  Event *movePlayer = [[Event alloc] initWithID:player.uuid
                                       selector:@selector(walkTo:)
                                        payload:[NSValue value:&pos withObjCType:@encode(GLKVector2)]];
  Event *panCamera = [[Event alloc] initWithID:@"c"
                                      selector:@selector(panCameraToTarget:)
                                       payload:[NSValue value:&pos withObjCType:@encode(GLKVector2)]];
  [eventQueue_ addObject:movePlayer];
  [eventQueue_ addObject:panCamera];
}



- (void)addTwoFingerTapEvent:(UITapGestureRecognizer *)gr {
  NSLog(@"two finger tap from event queue");
}



- (void)executeEvents {
  for (Event *e in eventQueue_) {
    if ([e.entityID isEqualToString:@"c"]) {
      [camera_ performSelector:e.func withObject:e.payload];
    } else {
      Entity *ent = [entityManager_ findById:e.entityID];
      [ent.behavior performSelector:e.func withObject:e.payload];
    }
  }
}



- (void)clearEvents {
  [eventQueue_ removeAllObjects];
}

@end
