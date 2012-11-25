//
//  Entity.m
//  Component
//
//  Created by Cjab on 11/1/12.
//  Copyright (c) 2012 Cjab. All rights reserved.
//

#import "Entity.h"

#import "Sprite.h"
#import "Component.h"

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
      if (componentClass == nil) {
        NSLog(@"ERROR: Attempted to load nonexistent class with name %@ in entity loader", className);
        exit(0);
      }

      NSDictionary *attributes = [components valueForKey:componentName];
      Component *component     = [[componentClass alloc] initWithEntity:self
                                                           dictionary:attributes];

      [self setComponent:component withString:className];
    }
    
    NSDictionary *sprites = [data valueForKey:@"sprites"];
    for (NSString *spriteName in sprites) {
      NSString *filePath  = [[sprites valueForKey:spriteName]
                             valueForKey:@"filePath"];
      int layer           = [[[sprites valueForKey:spriteName]
                              valueForKey:@"layer"] intValue];
      sprite_ = [[Sprite alloc] initWithFile:filePath layer:layer tag:spriteName];
      NSDictionary *children = [[sprites valueForKey:spriteName]
                                valueForKey:@"children"];
      if (children != nil) {
        for (NSString *childName in children) {
          NSString *filePath  = [[children valueForKey:childName]
                                 valueForKey:@"filePath"];
          int layer           = [[[children valueForKey:childName]
                                  valueForKey:@"layer"] intValue];
          Sprite *child = [[Sprite alloc] initWithFile:filePath layer:layer tag:childName];
          [child translate:GLKVector2Make(0, -((float)sprite_.height)/2.f - 5)];
          child.visible = FALSE;
          [sprite_ addChild:child];
        }
      }
    }
  }
  return self;
}



- (void)update {
  for (id key in components_) {
    [[components_ objectForKey:key] update];
  }
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



- (Sprite *)getSpriteByTag:(NSString *)tag {
  if ([sprite_.tag isEqualToString:tag]) {
    return sprite_;
  }
  if (sprite_.children != nil) {
    for (Sprite *child in sprite_.children) {
      if ([child.tag isEqualToString:tag]) {
        return child;
      }
    }
  }
  return nil;
}

@end