//
//  Team.h
//  SnoBros2
//
//  Created by Chad Jablonski on 11/26/12.
//  Copyright (c) 2012 Attack Slug. All rights reserved.
//

#import "Component.h"

@interface Team : Component {
  NSString *name_;
}

@property (nonatomic) NSString *name;

- (id)initWithEntity:(Entity *)entity;
- (id)initWithEntity:(Entity *)entity dictionary:(NSDictionary *)data;

@end