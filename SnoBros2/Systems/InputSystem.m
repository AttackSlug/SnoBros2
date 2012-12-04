//
//  Input.m
//  Component
//
//  Created by Chad Jablonski on 11/5/12.
//  Copyright (c) 2012 Attack Slug. All rights reserved.
//

#import "InputSystem.h"

#import "Entity.h"
#import "Camera.h"
#import "Selectable.h"
#import "Health.h"
#import "EntityManager.h"
#import "SelectionSystem.h"
#import "Attack.h"

@implementation InputSystem

- (id)initWithView:(UIView *)view
     entityManager:(EntityManager *)entityManager
   selectionSystem:(SelectionSystem *)selectionSystem
            camera:(Camera *)camera {
  self = [super init];
  if (self) {
    entityManager_   = entityManager;
    selectionSystem_ = selectionSystem;
    camera_        = camera;

    oneFingerTap_ = [[UITapGestureRecognizer alloc]
                     initWithTarget:self
                             action:@selector(addOneFingerTapEvent:)];
    oneFingerTap_.numberOfTapsRequired = 1;
    oneFingerTap_.numberOfTouchesRequired = 1;
    [view addGestureRecognizer:oneFingerTap_];

    twoFingerTap_ = [[UITapGestureRecognizer alloc]
                     initWithTarget:self
                             action:@selector(addTwoFingerTapEvent:)];
    twoFingerTap_.numberOfTapsRequired = 1;
    twoFingerTap_.numberOfTouchesRequired = 2;
    [view addGestureRecognizer:twoFingerTap_];

    boxSelector_ = [[UIPanGestureRecognizer alloc]
                    initWithTarget:self
                            action:@selector(addBoxSelectorEvent:)];
    boxSelector_.minimumNumberOfTouches = 1;
    boxSelector_.maximumNumberOfTouches = 1;
    [view addGestureRecognizer:boxSelector_];
  }
  return self;
}



- (void)addOneFingerTapEvent:(UITapGestureRecognizer *)gr {
  CGPoint p = [gr locationInView:gr.view];
  GLKVector2 pos = GLKVector2Add(GLKVector2Make(p.x, p.y), camera_.position);

  if ([selectionSystem_ isEntitySelected] == TRUE) {
    NSArray *selectedEntities = [selectionSystem_ findAllSelected];

    for (Entity *e in selectedEntities) {
      NSValue *target    = [NSValue value:&pos withObjCType:@encode(GLKVector2)];
      Health *health = [e getComponentByString:@"Health"];
      [health heal:40];

      NSDictionary *pathData = @{@"entity": e, @"target": target};
      [[NSNotificationCenter defaultCenter] postNotificationName:@"findPath"
                                                          object:self
                                                        userInfo:pathData];



      //NSString *walkTo       = [e.uuid stringByAppendingString:@"|walkTo"];
      //[[NSNotificationCenter defaultCenter] postNotificationName:walkTo
      //                                                    object:self
      //                                                  userInfo:data];

      NSDictionary *panData = @{@"target": target};
      NSString *panCamera = @"panCameraToTarget";
      [[NSNotificationCenter defaultCenter] postNotificationName:panCamera
                                                          object:self
                                                        userInfo:panData];
    }
  } else {
    [selectionSystem_ selectEntityDisplayedAtPosition:pos];
  }
}



- (void)addTwoFingerTapEvent:(UITapGestureRecognizer *)gr {
  [selectionSystem_ deselectAll];
  NSArray *units   = [entityManager_ findByTeamName:@"Team Edward"];
  NSArray *targets = [entityManager_ findByTeamName:@"Team Jacob"];

  for (Entity *unit in units) {
    Attack  *attack  = [unit getComponentByString:@"Attack"];
    if (targets.count > 0) {
      Entity  *target  = targets[arc4random() % targets.count];
      Health  *health  = [unit getComponentByString:@"Health"];

      [health damage:20];

      [attack fireAt:target];
    }
  }
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

    [selectionSystem_ selectAllWithinRectangle:rectangle];
  }
}

@end