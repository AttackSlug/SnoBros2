//
//  Collision.h
//  SnoBros2
//
//  Created by Cjab on 11/12/12.
//  Copyright (c) 2012 Cjab. All rights reserved.
//

#import "Component.h"
#import "Physics.h"
#import "Transform.h"

@class Scene;
@class Entity;

@interface Collision : Component {
  Scene     *scene_;
  Physics   *physics_;
  Transform *transform_;
  float      radius_;
}


@property (nonatomic) float radius;


- (id)initWithEntity:(Entity *)entity
           transform:(Transform *)transform
             physics:(Physics *)physics
               scene:(Scene *)scene
              radius:(float)radius;

- (void)update;
- (CGRect)boundingBox;

@end