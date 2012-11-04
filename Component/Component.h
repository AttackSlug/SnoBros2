//
//  Component.h
//  Component
//
//  Created by Cjab on 11/1/12.
//  Copyright (c) 2012 Cjab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Entity.h"
#import "Message.h"

@interface Component : NSObject {
  Entity *entity_;
}

- (id)initWithEntity:(Entity *)entity;

- (void)receiveMessage:(Message *)message;

@end
