//
//  Input.m
//  Component
//
//  Created by Chad Jablonski on 11/5/12.
//  Copyright (c) 2012 Attack Slug. All rights reserved.
//

#import "InputSystem.h"

#import "Entity.h"
#import "CameraSystem.h"
#import "Selectable.h"
#import "Health.h"
#import "EntityManager.h"
#import "UIManager.h"
#import "Attack.h"
#import "Transform.h"

#import "BoundingBox.h"

@implementation InputSystem

- (id)initWithView:(UIView *)view
     entityManager:(EntityManager *)entityManager
         UIManager:(UIManager *)UIManager 
            camera:(CameraSystem *)camera {
  self = [super init];
  if (self) {
    entityManager_  = entityManager;
    UIManager_      = UIManager;
    camera_         = camera;

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

    buttonTap_    = [[UITapGestureRecognizer alloc]
                     initWithTarget:self
                             action:@selector(addButtonTapEvent:)];
    buttonTap_.numberOfTapsRequired = 1;
    buttonTap_.numberOfTouchesRequired = 1;
    
    boxSelector_ = [[UIPanGestureRecognizer alloc]
                    initWithTarget:self
                            action:@selector(addBoxSelectorEvent:)];
    boxSelector_.minimumNumberOfTouches = 1;
    boxSelector_.maximumNumberOfTouches = 1;
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

      NSDictionary *pathData = @{@"entity": e, @"target": target};
      [[NSNotificationCenter defaultCenter] postNotificationName:@"findPath"
                                                          object:self
                                                        userInfo:pathData];

      NSDictionary *panData = @{@"target": target};
      NSString *panCamera = @"panCameraToTarget";
      [[NSNotificationCenter defaultCenter] postNotificationName:panCamera
                                                          object:self
                                                        userInfo:panData];
    }
  } else {
    NSDictionary *selectData = @{@"position": [NSValue value:&pos withObjCType:@encode(GLKVector2)]};
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"selectUnitAtPosition"
                                                        object:self
                                                      userInfo:selectData];
  }
}



- (void)addTwoFingerTapEvent:(UITapGestureRecognizer *)gr {
  NSArray *units   = [entityManager_ findByTeamName:@"Team Edward"];
  NSArray *targets = [entityManager_ findByTeamName:@"Team Jacob"];

  for (Entity *unit in units) {
    Attack  *attack  = [unit getComponentByString:@"Attack"];
    if (targets.count > 0) {
      Entity  *target  = targets[arc4random() % targets.count];
      Transform *targetTransform = [target getComponentByString:@"Transform"];

      [attack fireAt:targetTransform.position];
    }
  }
}



- (void)addButtonTapEvent:(UITapGestureRecognizer *)gr {
  [[NSNotificationCenter defaultCenter] postNotificationName:@"togglePause"
                                                      object:self
                                                    userInfo:nil];
}



- (void)addBoxSelectorEvent:(UIPanGestureRecognizer *)gr {
  if (gr.state == UIGestureRecognizerStateEnded) {
    CGPoint  e, t;

    e = [gr locationInView:gr.view  ];
    t = [gr translationInView:gr.view];

    GLKVector2 origin = GLKVector2Make(e.x - t.x + camera_.position.x,
                                       e.y - t.y + camera_.position.y);
    CGSize     size   = CGSizeMake(t.x, t.y);

    BoundingBox *selectionBox = [[BoundingBox alloc] initWithOrigin:origin
                                                               size:size];

    NSDictionary *selectData = @{@"boundingBox" : selectionBox};
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"selectAllWithinBoundingBox"
                                                        object:self
                                                      userInfo:selectData];
  }
}



- (void)update {
  
}



- (void)activate {
  [[UIManager_ viewWithName:@"Root"] addGestureRecognizer:oneFingerTap_];
  [[UIManager_ viewWithName:@"Root"] addGestureRecognizer:twoFingerTap_];
  [[UIManager_ viewWithName:@"button"] addGestureRecognizer:buttonTap_];
  [[UIManager_ viewWithName:@"Root"] addGestureRecognizer:boxSelector_];
}



- (void)deactivate {
  [[UIManager_ viewWithName:@"Root"] removeGestureRecognizer:oneFingerTap_];
  [[UIManager_ viewWithName:@"Root"] removeGestureRecognizer:twoFingerTap_];
  [[UIManager_ viewWithName:@"button"] removeGestureRecognizer:buttonTap_];
  [[UIManager_ viewWithName:@"Root"] removeGestureRecognizer:boxSelector_];
}

@end