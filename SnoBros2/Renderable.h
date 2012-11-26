//
//  Renderable.h
//  SnoBros2
//
//  Created by Tanoy Sinha on 11/25/12.
//  Copyright (c) 2012 Cjab. All rights reserved.
//

#import "Component.h"

@class Sprite;

@interface Renderable : Component {
  NSMutableArray  *sprites_;
  int             layer_;
}

@property (nonatomic)           int             layer;
@property (nonatomic, readonly) NSMutableArray  *sprites;

- (id)initWithEntity:(Entity *)entity;
- (id)initWithEntity:(Entity *)entity dictionary:(NSDictionary *)data;

- (Sprite *)getSpriteByTag:(NSString *)tag;
- (Sprite *)getSpriteByTag:(NSString *)tag
           fromSpriteArray:(NSMutableArray *)spriteArray;
- (Sprite *)loadSpriteFromDictionary:(NSDictionary *)data
                            withName:(NSString *)spriteName;
- (NSMutableArray *)loadSpritesFromDictionary:(NSDictionary *)data;

@end