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
}

@property GLKVector2 position;


- (id)initWithEntity:(Entity *)entity;

- (void)translate:(GLKVector2)translation;

@end
