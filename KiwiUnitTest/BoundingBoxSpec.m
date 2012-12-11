#import "Kiwi.h"
#import "BoundingBox.h"

#import <GLKit/GLKit.h>

SPEC_BEGIN(BoundingBoxSpec)

describe(@"BoundingBox", ^{

  __block BoundingBox *boundingBox;
  CGSize     size   = CGSizeMake(1.f, 1.f);
  GLKVector2 origin = GLKVector2Make(0.5f, 0.5f);


  beforeEach(^{
    boundingBox = [[BoundingBox alloc] initWithOrigin:origin size:size];
  });


  describe(@"#containsPoint:", ^{

    it(@"should return true if the box contains the point", ^{
      BOOL result = [boundingBox containsPoint:CGPointMake(0.5f, 0.75f)];
      [[theValue(result) should] beTrue];
    });

    it(@"should return false if the box does NOT contain the point", ^{
      BOOL result = [boundingBox containsPoint:CGPointMake(50.f, 50.f)];
      [[theValue(result) should] beFalse];
    });
  });


  describe(@"#intersectsWith:", ^{

    it(@"should return true if the boxes intersect", ^{
      GLKVector2 otherOrigin = GLKVector2Make(1.f, 1.f);
      CGSize     otherSize   = CGSizeMake(0.25f, 0.25f);
      BoundingBox *otherBox  = [[BoundingBox alloc] initWithOrigin:otherOrigin
                                                              size:otherSize];
      BOOL result = [boundingBox intersectsWith:otherBox];
      [[theValue(result) should] beTrue];
    });


    it(@"should return false if the boxes do NOT intersect", ^{
      GLKVector2 otherOrigin = GLKVector2Make(50.f, 50.f);
      CGSize     otherSize   = CGSizeMake(0.25f, 0.25f);
      BoundingBox *otherBox  = [[BoundingBox alloc] initWithOrigin:otherOrigin
                                                              size:otherSize];
      BOOL result = [boundingBox intersectsWith:otherBox];
      [[theValue(result) should] beFalse];
    });
  });


  describe(@"#setX", ^{

    it(@"should set the y value of the origin", ^{
      boundingBox.x = 5.f;
      [[theValue(boundingBox.x) should] equal:theValue(5.f)];
    });
  });


  describe(@"#setY", ^{

    it(@"should set the y value of the origin", ^{
      boundingBox.y = 5.f;
      [[theValue(boundingBox.y) should] equal:theValue(5.f)];
    });
  });


  describe(@"#setWidth", ^{

    it(@"should set the width", ^{
      boundingBox.width = 5.f;
      [[theValue(boundingBox.width) should] equal:theValue(5.f)];
    });
  });


  describe(@"#setHeight", ^{

    it(@"should set the height", ^{
      boundingBox.height = 5.f;
      [[theValue(boundingBox.height) should] equal:theValue(5.f)];
    });
  });
});

SPEC_END