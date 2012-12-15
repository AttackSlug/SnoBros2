#import "Kiwi.h"
#import "EntityManager.h"
#import "Entity.h"
#import "Pathfinder.h"
#import "MapGrid.h"
#import "MapNode.h"
#import "Transform.h"
#import "Collision.h"

#import "BoundingBox.h"

SPEC_BEGIN(PathfinderSpec)

describe(@"Pathfinder", ^{

  __block MapGrid       *map;
  __block Pathfinder    *pathfinder;
  __block EntityManager *entityManager;
  __block BoundingBox   *bounds;

  GLKVector2 origin = GLKVector2Make(2.f, 2.f);
  CGSize boundsSize = CGSizeMake(4.f, 4.f);

  CGSize size         = CGSizeMake(1.f, 1.f);
  Heuristic heuristic = [Pathfinder manhattanDistance];


  beforeEach(^{
    entityManager = [[EntityManager alloc] init];
    bounds        = [[BoundingBox alloc] initWithOrigin:origin
                                                   size:boundsSize];
    map           = [[MapGrid alloc] initWithBounds:bounds nodeSize:size];
    pathfinder    = [[Pathfinder alloc] initWithHeuristic:heuristic
                                            entityManager:entityManager];

    [entityManager loadEntityTypesFromFile:@"entities"];
  });


  context(@"given a map without obstacles", ^{

    it(@"should find a path", ^{
      MapNode *start = [map findNodeByGridCoordinatesX: 0 Y: 0];
      MapNode *end   = [map findNodeByGridCoordinatesX: 3 Y: 3];

      NSArray *path = [pathfinder findPathFrom:start to:end forEntity:nil];

      [[path[0] should] equal:[map findNodeByGridCoordinatesX:1 Y:1]];
      [[path[1] should] equal:[map findNodeByGridCoordinatesX:2 Y:2]];
      [[path[2] should] equal:end];
    });
  });


  context(@"given a map WITH obstacles", ^{

    __block Entity *obstacle;

    beforeEach(^{
      obstacle             = [entityManager buildEntity:@"Obstacle"];
      [entityManager add:obstacle];
      Transform *transform = [obstacle getComponentByString:@"Transform"];
      Collision *collision = [obstacle getComponentByString:@"Collision"];
      transform.position   = GLKVector2Make(1.5f, 1.5f);
      collision.radius     = 0.5f;
    });


    it(@"should find a path", ^{
      MapNode *start = [map findNodeByGridCoordinatesX: 0 Y: 0];
      MapNode *end   = [map findNodeByGridCoordinatesX: 3 Y: 3];

      NSArray *path  = [pathfinder findPathFrom:start to:end forEntity:nil];


      [[path[0] should] equal:[map findNodeByGridCoordinatesX:1 Y:0]];
      [[path[1] should] equal:[map findNodeByGridCoordinatesX:2 Y:1]];
      [[path[2] should] equal:[map findNodeByGridCoordinatesX:3 Y:2]];
      [[path[3] should] equal:end];
    });
  });
});

SPEC_END