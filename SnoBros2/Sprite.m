//
//  Sprite.m
//  Component
//
//  Created by Cjab on 11/4/12.
//  Copyright (c) 2012 Cjab. All rights reserved.
//

#import "Sprite.h"

@implementation Sprite

@synthesize vertices = vertices_;
@synthesize uvMap    = uvMap_;
@synthesize texture  = texture_;

- (id)initWithFile:(NSString *)filePath {
  self = [super init];
  if (self) {
    texture_  = [GLKTextureLoader
                textureWithCGImage:[UIImage imageNamed:filePath].CGImage
                options:nil
                error:nil];

    float halfWidth  = texture_.width  / 2.f;
    float halfHeight = texture_.height / 2.f;

    vertices_    = malloc(sizeof(GLKVector2) * 4);
    vertices_[0] = GLKVector2Make(-halfWidth,  halfHeight);
    vertices_[1] = GLKVector2Make(-halfWidth, -halfHeight);
    vertices_[2] = GLKVector2Make( halfWidth, -halfHeight);
    vertices_[3] = GLKVector2Make( halfWidth,  halfHeight);


    uvMap_    = malloc(sizeof(GLKVector2) * 4);
    uvMap_[0] = GLKVector2Make(0, 1);
    uvMap_[1] = GLKVector2Make(0, 0);
    uvMap_[2] = GLKVector2Make(1, 0);
    uvMap_[3] = GLKVector2Make(1, 1);
  }

  return self;
}



- (void)dealloc {
  free(vertices_);
  free(uvMap_);
}



- (unsigned)width {
  return texture_.width;
}



- (unsigned)height {
  return texture_.height;
}

@end