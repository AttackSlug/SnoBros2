//
//  Pathfinding.h
//  SnoBros2
//
//  Created by Cjab on 12/3/12.
//  Copyright (c) 2012 Attack Slug. All rights reserved.
//

#import <GLKit/GLKit.h>

#import "Component.h"

@interface Pathfinding : Component {
  NSArray *waypoints_;
  int      currentWaypointIndex_;
}

@property (nonatomic)           NSArray *waypoints;

- (id)initWithEntity:(Entity *)entity;
- (id)initWithEntity:(Entity *)entity dictionary:(NSDictionary *)data;

- (GLKVector2)nextWaypoint;
- (GLKVector2)currentWaypoint;

@end