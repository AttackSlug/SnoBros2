//
//  CreateEntity.h
//  Component
//
//  Created by Cjab on 11/7/12.
//  Copyright (c) 2012 Cjab. All rights reserved.
//

#import "Event.h"
#import "Entity.h"

@interface CreateEntity : Event {
  Entity *entity_;
}

@property (nonatomic) Entity *entity;


- (id)initWithEntity:(Entity *)entity;


@end