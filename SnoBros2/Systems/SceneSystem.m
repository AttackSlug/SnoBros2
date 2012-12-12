//
//  SceneSystem.m
//  SnoBros2
//
//  Created by Tanoy Sinha on 12/12/12.
//  Copyright (c) 2012 Attack Slug. All rights reserved.
//

#import "SceneSystem.h"

#import "EntityManager.h"
#import "SpriteManager.h"
#import "Sprite.h"
#import "BoundingBox.h"
#import "Camera.h"
#import "SceneGraph.h"
#import "SceneNode.h"
#import "Entity.h"
#import "Transform.h"

@implementation SceneSystem

- (id)initWithEntityManager:(EntityManager *)entityManager
              spriteManager:(SpriteManager *)spriteManager
                     camera:(Camera *)camera {
  self = [super init];
  if (self) {
    entityManager_  = entityManager;
    spriteManager_  = spriteManager;
    camera_         = camera;
  }
  return self;
}



- (void)update {
  [self updateViewableEntities];
}



- (void)updateViewableEntities {
  NSMutableArray *entitiesToDraw = [entityManager_ findAllWithComponent:@"SceneGraph"];
  BoundingBox *cameraBox = [[BoundingBox alloc] initWithOrigin:camera_.position
                                                            size:CGSizeMake(camera_.viewport.x,
                                                                            camera_.viewport.y)];
  
  for (int i = 0; i < [entitiesToDraw count]; i++) {
    Entity *entity = [entitiesToDraw objectAtIndex:i];
    SceneGraph *sceneGraph = [entity getComponentByString:@"SceneGraph"];
    Sprite *sprite = [spriteManager_ getSpriteWithRef:sceneGraph.rootNode.spriteName];
    Transform *transform  = [entity getComponentByString:@"Transform"];
    BoundingBox *entityBox = [[BoundingBox alloc] initWithOrigin:GLKVector2Make(transform.position.x,
                                                                                transform.position.y)
                                                            size:CGSizeMake(sprite.width,
                                                                            sprite.height)];
    
    if (![cameraBox intersectsWith:entityBox]) {
      [entitiesToDraw removeObjectAtIndex:i];
      i--;
    }
  }
  entitiesToDraw = [entityManager_ sortByLayer:entitiesToDraw];
  entityManager_.entitiesInViewPort = entitiesToDraw;
}

@end
