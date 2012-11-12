//
//  Entity.h
//  Component
//
//  Created by Cjab on 11/1/12.
//  Copyright (c) 2012 Cjab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Transform.h"
#import "Renderer.h"
#import "Physics.h"
#import "Input.h"
#import "Behavior.h"


@interface Entity : NSObject {
  Transform *transform_;
  Renderer  *renderer_;
  Physics   *physics_;
  Sprite    *sprite_;
  Input     *input_;
  Behavior  *behavior_;
  NSString  *tag_;
  NSString  *uuid_;
}

@property (nonatomic) Transform *transform;
@property (nonatomic) Renderer  *renderer;
@property (nonatomic) Physics   *physics;
@property (nonatomic) Sprite    *sprite;
@property (nonatomic) Input     *input;
@property (nonatomic) Behavior  *behavior;
@property (nonatomic) NSString  *tag;
@property (nonatomic) NSString  *uuid;

- (id)init;
- (id)initWithTag:(NSString*)tag;
- (void)update;
- (void)render;

@end