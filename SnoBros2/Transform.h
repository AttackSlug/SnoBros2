//
//  Transform.h
//  Component
//
//  Created by Cjab on 11/1/12.
//  Copyright (c) 2012 Cjab. All rights reserved.
//

#import <GLKit/GLKit.h>
#import "Component.h"

@interface Transform : Component {
  GLKVector2 position_;
  GLKVector2 previousPosition_;
}

@property (nonatomic) GLKVector2 position;
@property (nonatomic) GLKVector2 previousPosition;

- (id)initWithEntity:(Entity *)entity;
- (id)initWithEntity:(Entity *)entity dictionary:(NSDictionary *)data;

- (void)translate:(GLKVector2)translation;
- (Transform *)copy;

- (void)update;

@end