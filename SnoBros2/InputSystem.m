//
//  Input.m
//  Component
//
//  Created by Cjab on 11/5/12.
//  Copyright (c) 2012 Cjab. All rights reserved.
//

#import "InputSystem.h"

#import "Entity.h"
#import "Camera.h"
#import "Selectable.h"
#import "EntityManager.h"

#import "Attack.h"

@implementation InputSystem

- (id)initWithView:(UIView *)view
     entityManager:(EntityManager *)entityManager
            camera:(Camera *)camera {
  self = [super init];
  if (self) {
    entityManager_ = entityManager;
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

  if ([entityManager_ isEntitySelected] == TRUE) {
    NSArray *selectedEntities = [entityManager_ findAllSelected];

    for (Entity *e in selectedEntities) {
      NSValue *target    = [NSValue value:&pos withObjCType:@encode(GLKVector2)];
      NSDictionary *data = @{@"target": target};

      NSString *walkTo       = [@"walkTo:" stringByAppendingString:e.uuid];
      [[NSNotificationCenter defaultCenter] postNotificationName:walkTo
                                                          object:self
                                                        userInfo:data];

      NSString *panCamera = @"panCameraToTarget";
      [[NSNotificationCenter defaultCenter] postNotificationName:panCamera
                                                          object:self
                                                        userInfo:data];
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
  Entity *player = [entityManager_ findByTag:@"player"][0];
  Attack *attack = (Attack *)[player getComponentByString:@"Attack"];

  [attack fireAt:player];
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

@end