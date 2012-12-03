//
//  PathfinderTest.m
//  SnoBros2
//
//  Created by Chad Jablonski on 12/1/12.
//  Copyright (c) 2012 Attack Slug. All rights reserved.
//

#import "PathfinderTest.h"

#import "Pathfinder.h"
#import "MapNode.h"
#import "MapGrid.h"

@implementation PathfinderTest

- (void)setUp {
  [super setUp];
}



- (void)tearDown {
  [super tearDown];
}



- (void)testFindPathWithoutObstacles {
  CGRect bounds = CGRectMake(0.f, 0.f, 4.f, 4.f);
  CGSize size   = CGSizeMake(1.f, 1.f);

  Heuristic   heuristic  = [Pathfinder manhattanDistance];
  MapGrid    *map        = [[MapGrid alloc] initWithBounds:bounds nodeSize:size];
  Pathfinder *pathfinder = [[Pathfinder alloc] initWithMap:map
                                              andHeuristic:heuristic];

  MapNode *start = [map findNodeByX: 0 Y: 0];
  MapNode *end   = [map findNodeByX: 3 Y: 3];

  [pathfinder findPathFrom:start to:end];

  NSMutableArray *reversePath = [[NSMutableArray alloc] init];
  MapNode *current = end;
  while (current) {
    [reversePath addObject:current];
    current = current.parent;
  }
  NSArray *path = [[reversePath reverseObjectEnumerator] allObjects];

  STAssertEqualObjects(path[0], start, nil);
  STAssertEqualObjects(path[1], [map findNodeByX:1 Y:1], nil);
  STAssertEqualObjects(path[2], [map findNodeByX:2 Y:2], nil);
  STAssertEqualObjects(path[3], end, nil);
}



- (void)testFindPathWithASingleObstacle {
  CGRect bounds = CGRectMake(0.f, 0.f, 4.f, 4.f);
  CGSize size   = CGSizeMake(1.f, 1.f);

  Heuristic   heuristic  = [Pathfinder manhattanDistance];
  MapGrid    *map        = [[MapGrid alloc] initWithBounds:bounds nodeSize:size];
  Pathfinder *pathfinder = [[Pathfinder alloc] initWithMap:map
                                              andHeuristic:heuristic];

  MapNode *start    = [map findNodeByX: 0 Y: 0];
  MapNode *end      = [map findNodeByX: 3 Y: 3];
  MapNode *obstacle = [map findNodeByX: 1 Y: 1];

  obstacle.isTraversable = false;

  [pathfinder findPathFrom:start to:end];

  NSMutableArray *reversePath = [[NSMutableArray alloc] init];
  MapNode *current = end;
  while (current) {
    [reversePath addObject:current];
    current = current.parent;
  }
  NSArray *path = [[reversePath reverseObjectEnumerator] allObjects];

  STAssertEqualObjects(path[0], start, nil);
  STAssertEqualObjects(path[1], [map findNodeByX:1 Y:0], nil);
  STAssertEqualObjects(path[2], [map findNodeByX:2 Y:1], nil);
  STAssertEqualObjects(path[3], [map findNodeByX:3 Y:2], nil);
  STAssertEqualObjects(path[4], end, nil);
}

@end