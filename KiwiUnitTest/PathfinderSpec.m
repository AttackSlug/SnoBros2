//
// Licensed under the terms in License.txt
//
// Copyright 2010 Allen Ding. All rights reserved.
//

#import "Kiwi.h"
#import "Pathfinder.h"
#import "MapGrid.h"
#import "MapNode.h"

SPEC_BEGIN(PathfinderSpec)

describe(@"Pathfinder", ^{

  __block MapGrid *map;
  __block Pathfinder *pathfinder;
  CGRect bounds       = CGRectMake(0.f, 0.f, 4.f, 4.f);
  CGSize size         = CGSizeMake(1.f, 1.f);
  Heuristic heuristic = [Pathfinder manhattanDistance];


  beforeEach(^{
    map        = [[MapGrid alloc] initWithBounds:bounds nodeSize:size];
    pathfinder = [[Pathfinder alloc] initWithMap:map
                                    andHeuristic:heuristic];
  });


  context(@"given a map without obstacles", ^{

    it(@"should find a path", ^{
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

      [[path[0] should] equal:start];
      [[path[1] should] equal:[map findNodeByX:1 Y:1]];
      [[path[2] should] equal:[map findNodeByX:2 Y:2]];
      [[path[2] should] equal:end];
    });
  });


  context(@"given a map WITH obstacles", ^{

    __block MapNode *obstacle;

    beforeEach(^{
      obstacle = [map findNodeByX: 1 Y: 1];
    });


    it(@"should find a path", ^{
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

      [[path[0] should] equal:start];
      [[path[1] should] equal:[map findNodeByX:1 Y:0]];
      [[path[2] should] equal:[map findNodeByX:2 Y:1]];
      [[path[2] should] equal:[map findNodeByX:3 Y:2]];
      [[path[2] should] equal:end];
    });
  });
});

SPEC_END