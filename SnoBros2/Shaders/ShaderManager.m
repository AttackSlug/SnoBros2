//
//  ShaderManager.m
//  SnoBros2
//
//  Created by Tanoy Sinha on 12/2/12.
//  Copyright (c) 2012 Attack Slug. All rights reserved.
//

#import "ShaderManager.h"

#import "Shader.h"
#import "ShaderProgram.h"
#import "JSONLoader.h"

@implementation ShaderManager

- (id)init {
  self = [super init];
  if (self) {
    shaders_  = [[NSMutableDictionary alloc] init];
    programs_ = [[NSMutableDictionary alloc] init];
    activeProgram_ = nil;
  }
  return self;
}



- (void)loadShadersFromFile:(NSString *)fileName {
  JSONLoader *loader = [[JSONLoader alloc] init];
  shaders_ = [loader loadDictionaryFromFile:fileName keyField:@"Name"];
  
  for (id key in [shaders_ allKeys]) {
    [shaders_ setValue:[self loadShaderWithDictionary:shaders_[key]] forKey:key];
  }
}



- (Shader *)loadShaderWithDictionary:(NSDictionary *)data {
  return [[Shader alloc] initWithDictionary:data];
}



- (void)loadProgramsFromFile:(NSString *)fileName {
  JSONLoader *loader = [[JSONLoader alloc] init];
  programs_ = [loader loadDictionaryFromFile:fileName keyField:@"Name"];
  
  for (id key in [programs_ allKeys]) {
    [programs_ setValue:[self loadProgramWithDictionary:programs_[key]] forKey:key];
  }
}



- (ShaderProgram *)loadProgramWithDictionary:(NSDictionary *)data {
  NSString *name = data[@"Name"];
  NSArray *shaders = data[@"Shaders"];
  
  ShaderProgram *shaderProgram = [[ShaderProgram alloc] initWithName:name];
  
  for (NSString *shaderName in shaders) {
    [shaderProgram attachShader:[shaders_ objectForKey:shaderName]];
  }
  
  if ([shaderProgram linkProgram] == GL_FALSE) {
    NSLog(@"%@", [shaderProgram getInfoLog]);
    for (id key in shaders_) {
      Shader *shader = [shaders_ objectForKey:key];
      NSLog(@"%@ failed with: %@", shader.name, [shader getInfoLog]);
    }
  }
  
  return shaderProgram;
}



- (void)useProgramWithName:(NSString *)name {
  ShaderProgram *program = [programs_ objectForKey:name];
  activeProgram_ = program;
  glUseProgram(program.handle); 
}



- (NSMutableDictionary *)getActiveProgramVariables {
  return activeProgram_ == nil ? nil : [activeProgram_ getVariables];
}

@end
