//
//  ShaderManager.h
//  SnoBros2
//
//  Created by Tanoy Sinha on 12/2/12.
//  Copyright (c) 2012 Attack Slug. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ShaderProgram;
@class Shader;

@interface ShaderManager : NSObject {
  NSMutableDictionary *shaders_;
  NSMutableDictionary *programs_;
  ShaderProgram       *activeProgram_;
}

- (id)init;

- (void)loadShadersFromFile:(NSString *)fileName;
- (Shader *)loadShaderWithDictionary:(NSDictionary *)data;
- (void)loadProgramsFromFile:(NSString *)fileName;
- (ShaderProgram *)loadProgramWithDictionary:(NSDictionary *)data;

- (void)initPrograms;
- (void)useProgramWithName:(NSString *)name;
- (NSMutableDictionary *)getActiveProgramVariables;

@end
