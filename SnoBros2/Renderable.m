//
//  Renderable.m
//  SnoBros2
//
//  Created by Tanoy Sinha on 11/25/12.
//  Copyright (c) 2012 Cjab. All rights reserved.
//

#import "Renderable.h"
#import "Sprite.h"

@implementation Renderable

@synthesize layer = layer_;
@synthesize root  = root_;

- (id)initWithEntity:(Entity *)entity {
  self = [super initWithEntity:entity];
  if (self) {
    
  }
  return self;
}



- (id)initWithEntity:(Entity *)entity dictionary:(NSDictionary *)data {
  self = [self initWithEntity:entity];
  if (self) {
    NSDictionary *sprites = [data valueForKey:@"sprites"];
    for (NSString *spriteName in sprites) {
      root_ = [self loadSpriteFromDictionary:sprites withName:spriteName];
      NSDictionary *children = [[sprites valueForKey:spriteName]
                                valueForKey:@"children"];
      if (children != nil) {
        for (NSString *childName in children) {
          Sprite *child = [self loadSpriteFromDictionary:children withName:childName];
          [child translate:GLKVector2Make(0, -((float)root_.height)/2.f - 5)];
          child.visible = FALSE;
          [root_ addChild:child];
        }
      }
    }
    layer_ = [[data valueForKey:@"layer"] intValue];
  }
  return self;
}



- (Sprite *)getSpriteByTag:(NSString *)tag {
  if ([root_.tag isEqualToString:tag]) {
    return root_;
  }
  if (root_.children != nil) {
    for (Sprite *child in root_.children) {
      if ([child.tag isEqualToString:tag]) {
        return child;
      }
    }
  }
  return nil;
}




- (Sprite *)loadSpriteFromDictionary:(NSDictionary *)data withName:(NSString *)spriteName {
  NSString *filePath  = [[data valueForKey:spriteName]
                         valueForKey:@"filePath"];
  int layer           = [[[data valueForKey:spriteName]
                          valueForKey:@"layer"] intValue];
  return [[Sprite alloc] initWithFile:filePath layer:layer tag:spriteName];
}

@end
