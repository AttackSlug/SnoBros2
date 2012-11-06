//
//  Scene.h
//  Component
//
//  Created by Cjab on 11/6/12.
//  Copyright (c) 2012 Cjab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Entity.h"

@interface Scene : UIResponder {
  NSMutableArray *entities_;
}

- (id)init;
- (void)update;
- (void)render;

@end