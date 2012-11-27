//
//  SpriteManager.m
//  SnoBros2
//
//  Created by Tanoy Sinha on 11/27/12.
//  Copyright (c) 2012 Attack Slug. All rights reserved.
//

#import "SpriteManager.h"
#import "Sprite.h"

@implementation SpriteManager 

- (id)init {
  self = [super init];
  if (self) {
    spriteTypes_ = [[NSMutableDictionary alloc] init];
  }
  return self;
}



- (void)loadEntityTypesFromFile:(NSString *)filename {
  NSError  *error;
  NSString *path = [[NSBundle mainBundle]
                    pathForResource:filename ofType:@"json"];
  NSString *json = [[NSString alloc] initWithContentsOfFile:path
                                                   encoding:NSUTF8StringEncoding
                                                      error:&error];
  if (error) { NSLog(@"Error: %@", error); return; }
  
  NSData *data             = [json dataUsingEncoding:NSUTF8StringEncoding];
  NSDictionary *entityData = [NSJSONSerialization JSONObjectWithData:data
                                                             options:NSJSONReadingMutableContainers
                                                               error:&error];
  if (error) { NSLog(@"Error: %@", error); return; }
  
  if ([entityData isKindOfClass:[NSArray class]]) {
    for (NSDictionary *d in entityData) {
      NSString *name = [d valueForKey:@"Name"];
      Sprite *add = [self buildSpriteFromDictionary:d];
      [spriteTypes_ setValue:add forKey:name];
    }
  } else {
    NSString *name = [entityData valueForKey:@"Name"];
    Sprite *add = [self buildSpriteFromDictionary:entityData];
    [spriteTypes_ setValue:add forKey:name];
  }
}



- (Sprite *)buildSpriteFromDictionary:(NSDictionary *)spriteDict {
  return [[Sprite alloc] initWithFile:spriteDict[@"FileName"]];
}



- (Sprite *)getSpriteWithRef:(NSString *)spriteRef {
  return [spriteTypes_ objectForKey:spriteRef];
}



- (void)debug {
  for (id key in spriteTypes_) {
    Sprite *spr = [spriteTypes_ objectForKey:key];
    NSLog(@"Name: %@", key);
  }
}

@end
