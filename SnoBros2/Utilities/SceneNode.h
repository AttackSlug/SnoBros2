//
//  SceneNode.h
//  SnoBros2
//
//  Created by Tanoy Sinha on 11/27/12.
//  Copyright (c) 2012 Attack Slug. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GLKit/GLKit.h>

@class Sprite;

@interface SceneNode : NSObject {
  SceneNode       *parent_;
  NSMutableArray  *children_;
  Sprite          *sprite_;
  GLKMatrix4      modelViewMatrix_;
}

@property (nonatomic) SceneNode   *parent;
@property (nonatomic) GLKMatrix4  modelViewMatrix;

- (void)addChild:(SceneNode *)child;
- (void)addChildren:(NSArray *)children;

@end
