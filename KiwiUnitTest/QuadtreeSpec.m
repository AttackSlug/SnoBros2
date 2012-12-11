#import "Kiwi.h"
#import "Quadtree.h"
#import "BoundingBox.h"

SPEC_BEGIN(QuadtreeSpec)

describe(@"Quadtree", ^{

  __block Quadtree      *quadtree;
  __block BoundingBox   *bounds;
  __block int            mapWidth;
  __block int            mapHeight;

  beforeEach(^{
    mapWidth = mapHeight = 1024.f;

    bounds   = [[BoundingBox alloc] initWithX:mapWidth  / 2
                                            Y:mapHeight / 2
                                        width:mapWidth
                                       height:mapHeight];
    quadtree = [[Quadtree alloc] initWithBounds:bounds];
  });

  context(@"given a tree with fewer than the max objects per quad", ^{


    describe(@"#retrieveObjectsNear:", ^{

      it(@"should return all objects", ^{
        __block BoundingBox *boundingBox;
        for (int i = 0; i < quadtree.maxObjects; i++) {
          int x = (mapWidth  / quadtree.maxObjects) * i;
          int y = (mapHeight / quadtree.maxObjects) * i;

          boundingBox = [[BoundingBox alloc] initWithX:x
                                                     Y:y
                                                 width:5.f
                                                height:5.f];

          [quadtree addObject:@"someObject" withBoundingBox:boundingBox];
        }

        NSArray *objects = [quadtree retrieveObjectsNear:boundingBox];

        [[objects should] haveCountOf:quadtree.maxObjects];
      });
    });


    describe(@"#isLeafNode", ^{

      it(@"should return true if quadtree is a leaf node", ^{
        BOOL isLeafNode = [quadtree isLeafNode];
        [[theValue(isLeafNode) should] beTrue];
      });
    });


    describe(@"#isNotLeafNode", ^{

      it(@"should return false if quadtree is a leaf node", ^{
        BOOL isNotLeafNode = [quadtree isNotLeafNode];
        [[theValue(isNotLeafNode) should] beFalse];
      });
    });
  });


  context(@"given a tree with greater than the max objects per quad", ^{

    __block BoundingBox *boundingBox;

    beforeEach(^{
      for (int i = 0; i < quadtree.maxObjects * 3; i++) {
        int x = ((mapWidth  / quadtree.maxObjects) * i) % mapWidth;
        int y = ((mapHeight / quadtree.maxObjects) * i) % mapHeight;

        boundingBox = [[BoundingBox alloc] initWithX:x Y:y width:5.f height:5.f];

        [quadtree addObject:@"someObject" withBoundingBox:boundingBox];
      }
    });


 describe(@"#retrieveObjectsNear:", ^{

      it(@"should return a subset of the nearest objects", ^{
        NSArray *objects = [quadtree retrieveObjectsNear:boundingBox];
        [[objects should] haveCountOfAtMost:quadtree.maxObjects];
      });
    });


    describe(@"#isLeafNode", ^{

      it(@"should return false if quadtree is NOT a leaf node", ^{
        BOOL isLeafNode = [quadtree isLeafNode];
        [[theValue(isLeafNode) should] beFalse];
      });
    });


    describe(@"#isNotLeafNode", ^{

      it(@"should return true if quadtree is NOT a leaf node", ^{
        BOOL isNotLeafNode = [quadtree isNotLeafNode];
        [[theValue(isNotLeafNode) should] beTrue];
      });
    });
  });
});

SPEC_END