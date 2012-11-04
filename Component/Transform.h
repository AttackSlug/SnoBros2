//
//  Transform.h
//  Component
//
//  Created by Cjab on 11/1/12.
//  Copyright (c) 2012 Cjab. All rights reserved.
//

#import "Component.h"
#import <GLKit/GLKit.h>

@interface Transform : Component {
  GLKVector2 position_;
}

- (id)initWithEntity:(Entity *)entity;

- (void)translate:(GLKVector2)translation;

@end