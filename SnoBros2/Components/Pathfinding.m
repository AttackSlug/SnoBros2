//
//  Pathfinding.m
//  SnoBros2
//
//  Created by Cjab on 12/3/12.
//  Copyright (c) 2012 Attack Slug. All rights reserved.
//

#import "Pathfinding.h"

@implementation Pathfinding

@synthesize waypoints       = waypoints_;

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
  currentWaypointIndex_ += 1 % waypoints_.count;
  return [self currentWaypoint];
}



- (GLKVector2)currentWaypoint {
  GLKVector2 current;
  [waypoints_[currentWaypointIndex_] getValue:&current];
  return current;
}

@end