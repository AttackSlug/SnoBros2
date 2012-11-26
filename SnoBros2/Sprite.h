//
//  Sprite.h
//  Component
//
//  Created by Cjab on 11/4/12.
//  Copyright (c) 2012 Cjab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GLKit/GLKit.h>

@interface Sprite : NSObject {
  GLKVector2     *vertices_;
  GLKVector2     *uvMap_;
  GLKMatrix4     modelViewMatrix_;
  GLKTextureInfo *texture_;
  
  NSString       *tag_;
  
  BOOL           visible_;
  
  NSMutableArray *children_;
  Sprite         *parent_;
}

@property (readonly, nonatomic) unsigned width;
@property (readonly, nonatomic) unsigned height;
@property (readonly, nonatomic) GLKVector2 *vertices;
@property (readonly, nonatomic) GLKVector2 *uvMap;
@property (readonly, nonatomic) GLKMatrix4 modelViewMatrix;
@property (readonly, nonatomic) GLKTextureInfo *texture;
@property (readonly, nonatomic) NSString *tag;
@property (nonatomic)           BOOL visible;
@property (readonly, nonatomic) NSMutableArray *children;
@property (nonatomic)           Sprite *parent;

- (id)initWithFile:(NSString *)filePath tag:(NSString *)tag;

- (void)dealloc;
- (void)addChild:(Sprite *)child;
- (void)addChildren:(NSMutableArray *)children;
- (void)translate:(GLKVector2)translation;
- (void)cropByPercent:(float)percent;

@end