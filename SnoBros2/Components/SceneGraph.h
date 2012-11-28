//
//  SceneGraph.h
//  SnoBros2
//
//  Created by Tanoy Sinha on 11/25/12.
//  Copyright (c) 2012 Attack Slug. All rights reserved.
//

#import "Component.h"
#import <GLKit/GLKit.h>

@class SceneNode;

@interface SceneGraph : Component {
  SceneNode       *rootNode_;
  int             layer_;
}

@property (nonatomic)           int             layer;
@property (nonatomic, readonly) SceneNode       *rootNode;

- (id)initWithEntity:(Entity *)entity;
- (id)initWithEntity:(Entity *)entity dictionary:(NSDictionary *)data;

- (SceneNode *)loadGraphFromDictionary:(NSDictionary *)data;
- (NSMutableArray *)loadNodeArrayFromDictionary:(NSDictionary *)data;

- (SceneNode *)getNodeByName:(NSString *)name;
- (SceneNode *)getNodeByName:(NSString *)name fromSceneNode:(SceneNode *)node;

- (void)updateRootModelViewMatrix:(GLKMatrix4)modelViewMatrix;

@end