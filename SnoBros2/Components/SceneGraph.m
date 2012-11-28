//
//  SceneGraph.m
//  SnoBros2
//
//  Created by Tanoy Sinha on 11/25/12.
//  Copyright (c) 2012 Attack Slug. All rights reserved.
//

#import "SceneGraph.h"
#import "Sprite.h"
#import "SceneNode.h"

@implementation SceneGraph

@synthesize layer     = layer_;
@synthesize rootNode  = rootNode_;

- (id)initWithEntity:(Entity *)entity {
  self = [super initWithEntity:entity];
  if (self) {
  }
  return self;
}



- (id)initWithEntity:(Entity *)entity dictionary:(NSDictionary *)data {
  self = [self initWithEntity:entity];
  if (self) {
    rootNode_ = [self loadGraphFromDictionary:data];
    layer_   = [data[@"Layer"] intValue];
  }
  return self;
}



- (SceneNode *)loadGraphFromDictionary:(NSDictionary *)data {
  NSDictionary *dict = [data valueForKey:@"Nodes"];
  SceneNode *rootNode = [[SceneNode alloc] initWithSpriteRef:[dict valueForKey:@"Name"]];
  
  [rootNode addChildren:[self loadNodeArrayFromDictionary:[dict valueForKey:@"Children"]]];
  return rootNode;
}



- (NSMutableArray *)loadNodeArrayFromDictionary:(NSDictionary *)data {
  if ([data count] == 0) {
    return nil;
  }
  NSMutableArray *add = [[NSMutableArray alloc] init];
  for (NSString *dataKey in data) {
    SceneNode *temp = [[SceneNode alloc] initWithSpriteRef:dataKey];
    [temp addChildren:[self loadNodeArrayFromDictionary:[data valueForKey:dataKey]]];
    [add addObject:temp];
  }
  return add;
}



- (SceneNode *)getNodeByName:(NSString *)name {
  return [self getNodeByName:name fromSceneNode:rootNode_];
}



- (SceneNode *)getNodeByName:(NSString *)name fromSceneNode:(SceneNode *)node {
  SceneNode *found = nil;
  if ([node.spriteRef isEqualToString:name]) {
    found = node;
  }
  if (node.children) {
    for (SceneNode *child in node.children) {
      SceneNode *temp = [self getNodeByName:name fromSceneNode:child];
      found = temp == nil ? found : temp;
    }
  }
  return found;
}



- (void)updateRootModelViewMatrix:(GLKMatrix4)modelViewMatrix {
  rootNode_.modelViewMatrix = modelViewMatrix;
}

@end