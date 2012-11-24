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
      NSValue *position = [NSValue value:&pos withObjCType:@encode(GLKVector2)];
      Event *movePlayer = [[Event alloc] initWithType:@"walkTo"
                                               target:e.uuid
                                              payload:position];
      Event *panCamera = [[Event alloc] initWithType:@"panCameraToTarget"
                                              target:@"camera"
                                             payload:position];
      [eventQueue_ addObject:movePlayer];
      [eventQueue_ addObject:panCamera];
    }
  } else {
    NSArray *players = [entityManager_ findAllWithComponent:@"Selectable"];
    for (Entity *p in players) {
      Selectable *playerSelectable = [p getComponentByString:@"Selectable"];
      if ([playerSelectable isAtLocation:pos]) {
        playerSelectable.selected = TRUE;
      }
    }
  }
}



- (void)addTwoFingerTapEvent:(UITapGestureRecognizer *)gr {
  [entityManager_ deselectAll];
}



- (void)addBoxSelectorEvent:(UIPanGestureRecognizer *)gr {
  if (gr.state == UIGestureRecognizerStateEnded) {
    CGPoint  e, t;

    e = [gr locationInView:gr.view  ];
    t = [gr translationInView:gr.view];

    CGRect rectangle = CGRectMake(e.x - t.x + camera_.position.x,
                                  e.y - t.y + camera_.position.y,
                                  t.x,
                                  t.y);

    for (Entity *ent in [entityManager_ findAllWithComponent:@"Physics"]) {
      Selectable *entSelectable = [ent getComponentByString:@"Selectable"];
      if ([entSelectable isInRectangle:rectangle]) {
        entSelectable.selected = TRUE;
      }
    }
  }
}



- (void)executeEvents {
  for (Event *event in eventQueue_) {
    if ([event.target isEqualToString:@"camera"]) {
      //FIXME: Handle camera as a special case for now because it isn't an entity
      [camera_ receiveEvent:event];
    } else {
      Entity *entity = [entityManager_ findById:event.target];
      [entity receiveEvent:event];
    }
  }
}



- (void)clearEvents {
  [eventQueue_ removeAllObjects];
}

@end
