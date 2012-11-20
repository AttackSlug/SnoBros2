//
//  Selectable.h
//  SnoBros2
//
//  Created by Tanoy Sinha on 11/20/12.
//  Copyright (c) 2012 Cjab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GLKit/GLKit.h>
#import "Component.h"

@interface Selectable : Component {
  BOOL  selected_;
}

@property (nonatomic) BOOL selected;

- (id) initWithEntity:(Entity *)entity;
- (BOOL) isAtLocation:(GLKVector2)location;
@end
