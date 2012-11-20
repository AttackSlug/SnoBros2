//
//  Camera.h
//  SnoBros2
//
//  Created by Tanoy Sinha on 11/12/12.
//  Copyright (c) 2012 Cjab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GLKit/GLKit.h>

@class Game;
@class Event;

@interface Camera : NSObject {
  GLKVector2  position_;
  GLKVector2  target_;
  GLKVector2  viewport_;
  float       maxspeed_;
}

@property (readonly, nonatomic) GLKVector2 position;
@property (readonly, nonatomic) GLKVector2 target;
@property (readonly, nonatomic) GLKVector2 viewport;

- (void)panCameraWithHeading:(NSValue *)message;
- (void)panCameraToTarget:(NSValue *)message;
- (void)updateWithQueue:(Game *)queue;

@end
