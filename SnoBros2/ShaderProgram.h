//
//  ShaderProgram.h
//  SnoBros2
//
//  Created by Tanoy Sinha on 12/1/12.
//  Copyright (c) 2012 Attack Slug. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Shader;

@interface ShaderProgram : NSObject {
  NSMutableDictionary *shaders_;
  NSString            *name_;
  GLuint              handle_;
  GLint               linked_;
}

@property (nonatomic, readonly) NSString *name;
@property (nonatomic, readonly) GLuint handle;

- (id)init;
- (id)initWithName:(NSString *)name;

- (void)attachShader:(Shader *)shader;
- (GLint)linkProgram;
- (NSString *)getInfoLog;
- (NSMutableDictionary *)getVariablesWithNames:(NSMutableDictionary *)names;
- (NSMutableDictionary *)getVariables;

@end
