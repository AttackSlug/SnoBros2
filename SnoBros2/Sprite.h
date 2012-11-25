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
  GLKTextureInfo *texture_;
  int            layer_;
}

@property (readonly, nonatomic) unsigned width;
@property (readonly, nonatomic) unsigned height;
@property (readonly, nonatomic) GLKVector2 *vertices;
@property (readonly, nonatomic) GLKVector2 *uvMap;
@property (readonly, nonatomic) GLKTextureInfo *texture;
@property (readonly, nonatomic) int layer;

- (id)initWithFile:(NSString *)filePath;
- (id)initWithFile:(NSString *)filePath layer:(int)layer;
- (void)dealloc;

@end