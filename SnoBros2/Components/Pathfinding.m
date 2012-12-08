//
//  Pathfinding.m
//  SnoBros2
//
//  Created by Chad Jablonski on 12/3/12.
//  Copyright (c) 2012 Attack Slug. All rights reserved.
//

#import "Pathfinding.h"

@implementation Pathfinding

@synthesize waypoints       = waypoints_;
@synthesize currentWaypoint = currentWaypoint_;

- (id)initWithEntity:(Entity *)entity {
  self = [super initWithEntity:entity];
  if (self) {
  }
  return self;
}



- (id)initWithEntity:(Entity *)entity dictionary:(NSDictionary *)data {
  return [self initWithEntity:entity];
}



- (GLKVector2)nextWaypoint {
  NSValue *waypointValue = waypoints_[0];
  [waypointValue getValue:&currentWaypoint_];
  [waypoints_ removeObjectAtIndex:0];

  return currentWaypoint_;
}



- (bool)hasNextWaypoint {
  return !(waypoints_.count == 0);
}

@end