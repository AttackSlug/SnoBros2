//
//  Transform.h
//  Component
//
//  Created by Chad Jablonski on 11/1/12.
//  Copyright (c) 2012 Attack Slug. All rights reserved.
//

#import <GLKit/GLKit.h>
#import "Component.h"

@class BoundingBox;

@interface Transform : Component {
  GLKVector2 position_;
  GLKVector2 previousPosition_;
  GLKVector2 scale_;
}

@property (nonatomic) GLKVector2 position;
@property (nonatomic) GLKVector2 previousPosition;
@property (nonatomic) GLKVector2 scale;

- (id)initWithEntity:(Entity *)entity;
- (id)initWithEntity:(Entity *)entity dictionary:(NSDictionary *)data;

- (void)update;
- (void)translate:(GLKVector2)translation;
- (bool)isCenterInBoundingBox:(BoundingBox *)boundingBox;

@end