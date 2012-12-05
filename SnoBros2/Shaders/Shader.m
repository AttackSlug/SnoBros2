//
//  Shader.m
//  SnoBros2
//
//  Created by Tanoy Sinha on 12/1/12.
//  Copyright (c) 2012 Attack Slug. All rights reserved.
//

#import "Shader.h"

@implementation Shader

@synthesize type      = type_;
@synthesize name      = name_;
@synthesize handle    = handle_;
@synthesize compiled  = compiled_;
@synthesize variables = variables_;

- (id)initWithDictionary:(NSDictionary *)data {
  self = [super init];
  if (self) {
    name_ = data[@"Name"];
    type_ = data[@"Type"];
    variables_ = [[NSMutableDictionary alloc] init];
    NSDictionary *vars = data[@"Variables"];
    for (id key in vars) {
      [variables_ setObject:[vars objectForKey:key] forKey:key];
    }
    [self compile];
  }
  return self;
}



// compiles and returns compile status. if status is GL_FALSE, run getInfoLog
- (GLint)compile {
  NSString* shaderPath = [[NSBundle mainBundle] pathForResource:name_ ofType:@"glsl"];
  NSError* error;
  NSString* shaderString = [NSString stringWithContentsOfFile:shaderPath encoding:NSUTF8StringEncoding error:&error];
  if (!shaderString) {
    NSLog(@"Error loading shader: %@", error.localizedDescription);
    exit(1);
  }
  
  handle_ = glCreateShader([self enumFromString:type_]);
  
  const char *shaderStringUTF8 = [shaderString UTF8String];
  int shaderStringLength = [shaderString length];
  glShaderSource(handle_, 1, &shaderStringUTF8, &shaderStringLength);
  
  glCompileShader(handle_);
  
  GLint compileSuccess;
  glGetShaderiv(handle_, GL_COMPILE_STATUS, &compileSuccess);
  
  compiled_ = compileSuccess;
  
  return compileSuccess;
}



// in case of emergency
- (NSString *)getInfoLog {
  GLchar messages[256];
  glGetShaderInfoLog(handle_, sizeof(messages), 0, &messages[0]);
  NSString *messageString = [NSString stringWithUTF8String:messages];
  
  return messageString;
}



- (GLenum)enumFromString:(NSString *)string {
  if ([string isEqualToString:@"Vertex"]) {
    return GL_VERTEX_SHADER;
  } else {
    return GL_FRAGMENT_SHADER;
  }
}

@end
