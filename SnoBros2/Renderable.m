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

@synthesize layer   = layer_;
@synthesize sprites = sprites_;

- (id)initWithEntity:(Entity *)entity {
  self = [super initWithEntity:entity];
  if (self) {
    
  }
  return self;
}



- (id)initWithEntity:(Entity *)entity dictionary:(NSDictionary *)data {
  self = [self initWithEntity:entity];
  if (self) {
    sprites_ = [self loadSpritesFromDictionary:data];
    layer_ = [[data valueForKey:@"layer"] intValue];
  }
  return self;
}



- (Sprite *)getSpriteByTag:(NSString *)tag {
  return [self getSpriteByTag:tag fromSpriteArray:sprites_];
}



- (Sprite *)getSpriteByTag:(NSString *)tag fromSpriteArray:(NSMutableArray *)spriteArray {
  Sprite *found = nil;
  for (Sprite *sprite in spriteArray) {
    if ([sprite.tag isEqualToString:tag]) {
      found = sprite;
    } else if (sprite.children != nil) {
      Sprite *temp = [self getSpriteByTag:tag fromSpriteArray:sprite.children];
      found = (temp == nil) ? found : temp;
    }
  }
  return found;
}



- (Sprite *)loadSpriteFromDictionary:(NSDictionary *)data withName:(NSString *)spriteName {
  NSString *filePath  = [[data valueForKey:spriteName]
                         valueForKey:@"filePath"];
  return [[Sprite alloc] initWithFile:filePath tag:spriteName];
}



- (NSMutableArray *)loadSpritesFromDictionary:(NSDictionary *)data {
  NSDictionary *spriteDict = [data valueForKey:@"sprites"];
  if (spriteDict == nil) {
    return nil;
  }
  NSMutableArray *sprites = [[NSMutableArray alloc] init];
  for (NSString *spriteName in spriteDict) {
    Sprite *child = [self loadSpriteFromDictionary:spriteDict withName:spriteName];
    NSDictionary *childDict = [spriteDict valueForKey:spriteName];
    [child addChildren:[self loadSpritesFromDictionary:childDict]];
    [sprites addObject:child];
  }
  return sprites;
}

@end
