#import "Kiwi.h"
#import "MapGrid.h"
#import "MapNode.h"

SPEC_BEGIN(MapGridSpec)

describe(@"MapGrid", ^{

  __block MapGrid *map;
  CGRect bounds = CGRectMake(0.f, 0.f, 4.f, 4.f);
  CGSize size   = CGSizeMake(1.f, 1.f);


  beforeEach(^{
    map = [[MapGrid alloc] initWithBounds:bounds nodeSize:size];
  });


  context(@"given a map without obstacles", ^{

  });
});

SPEC_END