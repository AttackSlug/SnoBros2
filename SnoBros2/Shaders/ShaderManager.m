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

@implementation ShaderManager

- (id)init {
  self = [super init];
  if (self) {
    shaders_  = [[NSMutableDictionary alloc] init];
    //programs_ = [[NSMutableDictionary alloc] init];
    //[self initShaders];
    //[self initPrograms];
    //activeProgram_ = nil;
  }
  return self;
}



- (void)loadShadersFromFile:(NSString *)fileName {
  NSError  *error;
  NSString *path = [[NSBundle mainBundle]
                    pathForResource:fileName ofType:@"json"];
  NSString *json = [[NSString alloc] initWithContentsOfFile:path
                                                   encoding:NSUTF8StringEncoding
                                                      error:&error];
  if (error) { NSLog(@"Error: %@", error); return; }
  
  NSData *data             = [json dataUsingEncoding:NSUTF8StringEncoding];
  NSDictionary *shaderData = [NSJSONSerialization JSONObjectWithData:data
                                                             options:NSJSONReadingMutableContainers
                                                               error:&error];
  if (error) { NSLog(@"Error: %@", error); return; }
  
  if ([shaderData isKindOfClass:[NSArray class]]) {
    for (NSDictionary *d in shaderData) {
      NSString *name = [d valueForKey:@"Name"];
      Shader *add = [self loadShaderWithDictionary:d];
      [shaders_ setValue:add forKey:name];
    }
  } else {
    NSString *name = [shaderData valueForKey:@"Name"];
    Shader *add = [self loadShaderWithDictionary:shaderData];
    [shaders_ setValue:add forKey:name];
  }
}



- (Shader *)loadShaderWithDictionary:(NSDictionary *)data {
  return [[Shader alloc] initWithDictionary:data];
}



- (void)loadProgramsFromFile:(NSString *)fileName {
  NSError  *error;
  NSString *path = [[NSBundle mainBundle]
                    pathForResource:fileName ofType:@"json"];
  NSString *json = [[NSString alloc] initWithContentsOfFile:path
                                                   encoding:NSUTF8StringEncoding
                                                      error:&error];
  if (error) { NSLog(@"Error: %@", error); return; }
  
  NSData *data             = [json dataUsingEncoding:NSUTF8StringEncoding];
  NSDictionary *programData = [NSJSONSerialization JSONObjectWithData:data
                                                             options:NSJSONReadingMutableContainers
                                                               error:&error];
  if (error) { NSLog(@"Error: %@", error); return; }
  
  if ([programData isKindOfClass:[NSArray class]]) {
    for (NSDictionary *d in programData) {
      NSString *name = [d valueForKey:@"Name"];
      ShaderProgram *add = [self loadProgramWithDictionary:d];
      [programs_ setValue:add forKey:name];
    }
  } else {
    NSString *name = [programData valueForKey:@"Name"];
    ShaderProgram *add = [self loadProgramWithDictionary:programData];
    [programs_ setValue:add forKey:name];
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



- (void)initPrograms {
/*  ShaderProgram *shaderProgram = [[ShaderProgram alloc] init];
  
  [shaderProgram attachShader:[shaders_ objectForKey:@"SimpleVertex"]];
  [shaderProgram attachShader:[shaders_ objectForKey:@"SimpleFragment"]];
  if ([shaderProgram linkProgram] == GL_FALSE) {
    NSLog(@"%@", [shaderProgram getInfoLog]);
    for (id key in shaders_) {
      Shader *shader = [shaders_ objectForKey:key];
      NSLog(@"%@ failed with: %@", shader.name, [shader getInfoLog]);
    }
  }
  
  [programs_ setObject:shaderProgram forKey:@"Default"];
  
  ShaderProgram *bezierProgram = [[ShaderProgram alloc] init];
  
  [bezierProgram attachShader:[shaders_ objectForKey:@"BezierParticle"]];
  [bezierProgram attachShader:[shaders_ objectForKey:@"SimpleFragment"]];
  if ([bezierProgram linkProgram] == GL_FALSE) {
    NSLog(@"%@", [bezierProgram getInfoLog]);
    for (id key in shaders_) {
      Shader *shader = [shaders_ objectForKey:key];
      NSLog(@"%@ failed with: %@", shader.name, [shader getInfoLog]);
    }
  }
  
  [programs_ setObject:bezierProgram forKey:@"Bezier"]; */
}



- (void)useProgramWithName:(NSString *)name {
  ShaderProgram *program = [programs_ objectForKey:name];
  activeProgram_ = program;
  glUseProgram(program.handle); 
}



- (NSMutableDictionary *)getActiveProgramVariables {
  return activeProgram_ == nil ? activeProgram_ : [activeProgram_ getVariables];
}

@end
