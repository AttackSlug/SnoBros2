#import "Kiwi.h"
#import "MapGrid.h"
#import "MapNode.h"
#import "BoundingBox.h"

SPEC_BEGIN(MapGridSpec)

describe(@"MapGrid", ^{

  __block MapGrid *map;
  GLKVector2 origin   = GLKVector2Make(4.f, 4.f);
  CGSize size         = CGSizeMake(1.f, 1.f);
  BoundingBox *bounds = [[BoundingBox alloc] initWithOrigin:origin size:size];


  beforeEach(^{
    map = [[MapGrid alloc] initWithBounds:bounds nodeSize:size];
  });


  context(@"given a map without obstacles", ^{

  });
});

SPEC_END