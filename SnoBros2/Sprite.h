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
  int            layer_;
  NSMutableArray *children_;
  Sprite         *parent_;
}

@property (readonly, nonatomic) unsigned width;
@property (readonly, nonatomic) unsigned height;
@property (readonly, nonatomic) GLKVector2 *vertices;
@property (readonly, nonatomic) GLKVector2 *uvMap;
@property (readonly, nonatomic) GLKMatrix4 modelViewMatrix;
@property (readonly, nonatomic) GLKTextureInfo *texture;
@property (readonly, nonatomic) int layer;
@property (readonly, nonatomic) NSMutableArray *children;
@property (nonatomic) Sprite *parent;

- (id)initWithFile:(NSString *)filePath;
- (id)initWithFile:(NSString *)filePath layer:(int)layer;
- (void)dealloc;
- (void)addChild:(Sprite *)child;

@end