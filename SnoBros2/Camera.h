//
//  Camera.h
//  SnoBros2
//
//  Created by Tanoy Sinha on 11/12/12.
//  Copyright (c) 2012 Cjab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GLKit/GLKit.h>

@interface Camera : NSObject {
  GLKVector2  position_;
  GLKVector2  target_;
  float       maxspeed_;
}

@property (readonly, nonatomic) GLKVector2 position;
@property (readonly, nonatomic) GLKVector2 target;

-(void)moveCameraToTarget:(GLKVector2)target;
-(void)update;
@end
