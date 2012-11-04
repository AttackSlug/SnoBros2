//
//  Entity.h
//  Component
//
//  Created by Cjab on 11/1/12.
//  Copyright (c) 2012 Cjab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Message.h"

@class Component;


@interface Entity : NSObject {
  NSMutableDictionary *components_;
}

- (id)init;

- (void)addComponent:(Component *)component name:(NSString *)name;
- (Component *)componentWithName:(NSString *)name;
- (void)removeComponent:(NSString *)name;

- (void)receiveMessage:(Message *)message;

@end