//
//  JSONLoader.m
//  SnoBros2
//
//  Created by Tanoy Sinha on 12/14/12.
//  Copyright (c) 2012 Attack Slug. All rights reserved.
//

#import "JSONLoader.h"

@implementation JSONLoader

- (id)init {
  self = [super init];
  if (self) {
    
  }
  return self;
}



- (NSMutableDictionary *)loadDictionaryFromFile:(NSString *)fileName keyField:(NSString *)keyField {
  NSError  *error;
  NSString *path = [[NSBundle mainBundle]
                    pathForResource:fileName ofType:@"json"];
  NSString *json = [[NSString alloc] initWithContentsOfFile:path
                                                   encoding:NSUTF8StringEncoding
                                                      error:&error];
  if (error) { NSLog(@"Error: %@", error); return nil; }
  
  NSData *rawData             = [json dataUsingEncoding:NSUTF8StringEncoding];
  NSDictionary *dictData = [NSJSONSerialization JSONObjectWithData:rawData
                                                           options:NSJSONReadingMutableContainers
                                                             error:&error];
  if (error) { NSLog(@"Error: %@", error); return nil; }
  
  NSMutableDictionary *returnDict = [[NSMutableDictionary alloc] init];
  
  if ([dictData isKindOfClass:[NSArray class]]) {
    for (NSDictionary *subDict in dictData) {
      NSString *keyVal = [subDict valueForKey:keyField];
      [returnDict setValue:subDict forKey:keyVal];
    }
  } else {
    NSString *keyVal = [dictData valueForKey:keyField];
    [returnDict setValue:dictData forKey:keyVal];
  }
  
  return returnDict;
}

@end
