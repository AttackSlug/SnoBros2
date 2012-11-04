//
//  Entity.m
//  Component
//
//  Created by Cjab on 11/1/12.
//  Copyright (c) 2012 Cjab. All rights reserved.
//

#import "Entity.h"
#import "Component.h"

@implementation Entity


- (id)init {
  self = [super init];
  if (self) {
    components_ = [[NSMutableDictionary alloc] init];
  }
  return self;
}



- (void)addComponent:(Component *)component name:(NSString *)name {
  [components_ setValue:component forKey:name];
}



- (Component *)componentWithName:(NSString *)name {
  return [components_ objectForKey:name];
}



- (void)removeComponent:(NSString *)name {
  [components_ removeObjectForKey:name];
}



- (void)receiveMessage:(Message *)message {
  for (id key in components_) {
    [[components_ objectForKey:key] receiveMessage:message];
  }
}


@end