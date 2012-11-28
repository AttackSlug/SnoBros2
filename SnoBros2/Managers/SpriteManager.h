//
//  SpriteManager.h
//  SnoBros2
//
//  Created by Tanoy Sinha on 11/27/12.
//  Copyright (c) 2012 Attack Slug. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Sprite;

@interface SpriteManager : NSObject {
  NSMutableDictionary *spriteTypes_;
}

- (id)init;

- (void)loadEntityTypesFromFile:(NSString *)filename;
- (Sprite *)buildSpriteFromDictionary:(NSDictionary *)spriteDict;
- (Sprite *)getSpriteWithRef:(NSString *)spriteRef;

@end
