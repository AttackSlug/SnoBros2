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
}

@property (nonatomic, readonly) NSString  *entityID;
@property (nonatomic, readonly) SEL       func;

- (id)initWithID:(NSString*)uuid AndSelector:(SEL) func;

@end
