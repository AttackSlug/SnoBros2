//
//  RenderSystem.h
//  SnoBros2
//
//  Created by Tanoy Sinha on 11/24/12.
//  Copyright (c) 2012 Cjab. All rights reserved.
//

#import <Foundation/Foundation.h>

@class EntityManager;
@class Entity;
@class Camera;

@interface RenderSystem : NSObject {
  EntityManager *entityManager_;
  Camera        *camera_;
}

- (id)initWithEntityManager:(EntityManager *)entityManager camera:(Camera *)camera;

- (void)renderEntities;
- (void)renderEntity:(Entity *)entity withCamera:(Camera *)camera;

@end
