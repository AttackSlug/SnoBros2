//
//  Entity.h
//  Component
//
//  Created by Cjab on 11/1/12.
//  Copyright (c) 2012 Cjab. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Transform;
@class Renderer;
@class Physics;
@class Input;
@class Camera;
@class Behavior;
@class Collision;
@class Sprite;

@interface Entity : NSObject {
  Transform *transform_;
  Renderer  *renderer_;
  Physics   *physics_;
  Sprite    *sprite_;
  Behavior  *behavior_;
  Collision *collision_;
  NSString  *tag_;
  NSString  *uuid_;
}

@property (nonatomic) Transform *transform;
@property (nonatomic) Renderer  *renderer;
@property (nonatomic) Physics   *physics;
@property (nonatomic) Sprite    *sprite;
@property (nonatomic) Behavior  *behavior;
@property (nonatomic) Collision *collision;
@property (nonatomic) NSString  *tag;
@property (nonatomic) NSString  *uuid;

- (id)init;
- (id)initWithTag:(NSString*)tag;
- (void)update;
- (void)renderWithCamera:(Camera*)camera interpolationRatio:(double)ratio;

@end
