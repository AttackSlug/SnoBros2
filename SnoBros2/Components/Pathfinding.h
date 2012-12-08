//
//  Pathfinding.h
//  SnoBros2
//
//  Created by Chad Jablonski on 12/3/12.
//  Copyright (c) 2012 Attack Slug. All rights reserved.
//

#import <GLKit/GLKit.h>

#import "Component.h"

@interface Pathfinding : Component {
  NSMutableArray *waypoints_;
  GLKVector2      currentWaypoint_;
}

@property (nonatomic)           NSArray    *waypoints;
@property (nonatomic, readonly) GLKVector2  currentWaypoint;

- (id)initWithEntity:(Entity *)entity;
- (id)initWithEntity:(Entity *)entity dictionary:(NSDictionary *)data;

- (GLKVector2)nextWaypoint;
- (GLKVector2)currentWaypoint;
- (bool)hasNextWaypoint;

@end