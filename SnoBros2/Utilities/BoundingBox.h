//
//  BoundingBox.h
//  SnoBros2
//
//  Created by Cjab on 12/10/12.
//  Copyright (c) 2012 Attack Slug. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GLKit/GLKit.h>

@interface BoundingBox : NSObject {
  CGRect rectangle_;
}

@property (nonatomic) float x;
@property (nonatomic) float y;
@property (nonatomic) float width;
@property (nonatomic) float height;

- (id)initWithOrigin:(GLKVector2)origin size:(CGSize)size;
- (id)initWithX:(float)x Y:(float)y width:(float)size height:(float)height;

- (bool)intersectsWith:(BoundingBox *)other;
- (bool)containsPoint:(CGPoint)point;

@end