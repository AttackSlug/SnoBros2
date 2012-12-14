//
//  JSONLoader.h
//  SnoBros2
//
//  Created by Tanoy Sinha on 12/14/12.
//  Copyright (c) 2012 Attack Slug. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JSONLoader : NSObject

- (id)init;
- (NSMutableDictionary *)loadDictionaryFromFile:(NSString *)fileName keyField:(NSString *)keyField;

@end
