//
//  Entity.h
//  Component
//
//  Created by Chad Jablonski on 11/1/12.
//  Copyright (c) 2012 Attack Slug. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Camera;

@class Component;

@interface Entity : NSObject {
  NSString     *type_;
  NSString     *uuid_;
  
  NSMutableDictionary *components_;
}

@property (nonatomic) NSString    *type;
@property (nonatomic) NSString    *uuid;

@property (nonatomic) NSMutableDictionary *components;

- (id)init;
- (id)initWithType:(NSString *)type;
- (id)initWithDictionary:(NSDictionary *)data;

- (void)update;

- (id)getComponentByString:(NSString *)string;
- (void)setComponent:(Component *)component withString:(NSString *)string;
- (BOOL)hasComponent:(NSString *)string;

@end
