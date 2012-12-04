//
//  PathfindingSystem.h
//  SnoBros2
//
//  Created by Chad Jablonski on 12/3/12.
//  Copyright (c) 2012 Attack Slug. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GLKit/GLKit.h>

@class MapGrid;
@class EntityManager;
@class Entity;

@interface PathfindingSystem : NSObject {
  MapGrid       *map_;
  EntityManager *entityManager_;
}

- (void)update;
- (id)initWithEntityManager:(EntityManager *)entityManager;
- (bool)isEntity:(Entity *)entity atWaypoint:(GLKVector2)waypoint;

@end