//
//  Event.h
//  Component
//
//  Created by Cjab on 11/7/12.
//  Copyright (c) 2012 Cjab. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Event : NSObject {
  NSString  *id_;
  SEL       func_;
  NSValue   *payload_;
}

@property (nonatomic, readonly) NSString  *entityID;
@property (nonatomic, readonly) SEL       func;
@property (nonatomic, readonly) NSValue   *payload;

- (id)initWithID:(NSString*)uuid selector:(SEL) func payload:(NSValue*) payload;

@end
