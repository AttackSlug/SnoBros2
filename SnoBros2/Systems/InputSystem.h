//
//  Input.h
//  Component
//
//  Created by Chad Jablonski on 11/5/12.
//  Copyright (c) 2012 Attack Slug. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "GameSystem.h"

@class EntityManager;
@class UIManager;
@class CameraSystem;

@interface InputSystem : NSObject <GameSystem> {
  EntityManager             *entityManager_;
  UIManager                 *UIManager_;
  CameraSystem                    *camera_;

  UITapGestureRecognizer    *oneFingerTap_;
  UITapGestureRecognizer    *twoFingerTap_;
  UITapGestureRecognizer    *buttonTap_;
  UIPanGestureRecognizer    *boxSelector_;
}


- (id)initWithView:(UIView *)view
     entityManager:(EntityManager *)entityManager
         UIManager:(UIManager *)UIManager
            camera:(CameraSystem *)camera;
@end