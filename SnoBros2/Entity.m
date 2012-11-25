//
//  Entity.m
//  Component
//
//  Created by Cjab on 11/1/12.
//  Copyright (c) 2012 Cjab. All rights reserved.
//

#import "Entity.h"

#import "Renderer.h"

@implementation Entity

@synthesize uuid        = uuid_;
@synthesize tag         = tag_;
@synthesize sprite      = sprite_;

@synthesize components  = components_;

- (id)init {
  return [self initWithTag:@"untagged"];
}



- (id)initWithTag:(NSString *)tag {
  self = [super init];
  if (self) {
    tag_ = tag;
    CFUUIDRef uuid = CFUUIDCreate(NULL);
    uuid_ = (__bridge_transfer NSString *)CFUUIDCreateString(NULL, uuid);
    CFRelease(uuid);
    components_ = [[NSMutableDictionary alloc] init];
  }
  return self;
}



- (id)initWithDictionary:(NSDictionary *)data {
  self = [self initWithTag:[data valueForKey:@"tag"]];
  if (self) {
    NSDictionary *components = [data valueForKey:@"components"];
    for (NSString *componentName in components) {

      NSString *className  = [[components valueForKey:componentName]
                              valueForKey:@"type"];

      Class componentClass = NSClassFromString(className);

      NSDictionary *attributes = [components valueForKey:componentName];
      Component *component     = [[componentClass alloc] initWithEntity:self
                                                           dictionary:attributes];

      [self setComponent:component withString:className];
    }
  }
  return self;
}



- (void)update {
  for (id key in components_) {
    [[components_ objectForKey:key] update];
  }
}



- (void)renderWithCamera:(Camera*)camera interpolationRatio:(double)ratio {
  Renderer *renderer = [self getComponentByString:@"Renderer"];
  [renderer renderWithCamera:camera interpolationRatio:ratio];
}



- (id)getComponentByString:(NSString *)string {
  return [components_ objectForKey:string];
}



- (void)setComponent:(Component *)component withString:(NSString *)string {
  [components_ setObject:component forKey:string];
}



- (BOOL)hasComponent:(NSString *)string {
  return [components_ objectForKey:string] != nil;
}

@end