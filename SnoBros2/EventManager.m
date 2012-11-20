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
#import "Selectable.h"

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
  CGPoint p = [gr locationInView:gr.view];
  GLKVector2 pos = GLKVector2Add(GLKVector2Make(p.x, p.y), camera_.position);
  
  if ([entityManager_ isEntitySelected] == TRUE) {
    NSArray *selectedEntities = [entityManager_ findAllSelected];
    
    for (Entity *e in selectedEntities) {
      Event *movePlayer = [[Event alloc] initWithID:e.uuid
                                           selector:@selector(walkTo:)
                                            payload:[NSValue value:&pos withObjCType:@encode(GLKVector2)]];
      Event *panCamera = [[Event alloc] initWithID:@"c"
                                          selector:@selector(panCameraToTarget:)
                                           payload:[NSValue value:&pos withObjCType:@encode(GLKVector2)]];
      [eventQueue_ addObject:movePlayer];
      [eventQueue_ addObject:panCamera];
    }
  } else {
    NSArray *players = [entityManager_ findAllWithComponent:@"selectable"];
    for (Entity *p in players) {
      if ([p.selectable isAtLocation:pos]) {
        p.selectable.selected = TRUE;
      }
    }
  }
}



- (void)addTwoFingerTapEvent:(UITapGestureRecognizer *)gr {
  [entityManager_ deselectAll];
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



- (BOOL)isEntityUnderTouch:(Entity *)entity {
}

@end
