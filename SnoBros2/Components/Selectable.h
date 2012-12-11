//
//  Selectable.h
//  SnoBros2
//
//  Created by Tanoy Sinha on 11/20/12.
//  Copyright (c) 2012 Attack Slug. All rights reserved.
//

#import <GLKit/GLKit.h>

#import "Component.h"

@class BoundingBox;

@interface Selectable : Component {
  BOOL  selected_;
}

@property (nonatomic) BOOL selected;

- (id)initWithEntity:(Entity *)entity;
- (id)initWithEntity:(Entity *)entity dictionary:(NSDictionary *)data;

- (BOOL)isAtLocation:(GLKVector2)location;
- (BOOL)isInBoundingBox:(BoundingBox *)rectangle;

- (void)selectUnit;
- (void)deselectUnit;

@end