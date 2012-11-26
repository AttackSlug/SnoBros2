//
//  Health.h
//  SnoBros2
//
//  Created by Tanoy Sinha on 11/26/12.
//  Copyright (c) 2012 Cjab. All rights reserved.
//

#import "Component.h"

@class Sprite;

@interface Health : Component {
  float   health_;
  Sprite  *healthBar_;
}

@property (nonatomic) float health;

- (id)initWithEntity:(Entity *)entity;
- (id)initWithEntity:(Entity *)entity dictionary:(NSDictionary *)data;
- (void)showHealthBar;
- (void)hideHealthBar;

@end
