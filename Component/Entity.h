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
#import "AI.h"


@interface Entity : NSObject {
  Transform *transform_;
  Renderer  *renderer_;
  Physics   *physics_;
  Input     *input_;
  AI        *ai_;
}

@property (nonatomic) Transform *transform;
@property (nonatomic) Renderer  *renderer;
@property (nonatomic) Physics   *physics;
@property (nonatomic) Input     *input;
@property (nonatomic) AI        *ai;

- (id)init;
- (void)update;
- (void)render;

@end