//
//  Health.h
//  SnoBros2
//
//  Created by Tanoy Sinha on 11/26/12.
//  Copyright (c) 2012 Attack Slug. All rights reserved.
//

#import "Component.h"

@class SceneNode;

@interface Health : Component {
  float     health_;
  float     maxHealth_;
  BOOL      visible_;
  NSString  *spriteName_;
}

@property (nonatomic) float health;
@property (nonatomic) float maxHealth;
@property (nonatomic) BOOL visible;
@property (nonatomic) NSString *spriteName;

- (id)initWithEntity:(Entity *)entity;
- (id)initWithEntity:(Entity *)entity dictionary:(NSDictionary *)data;

- (void)damage:(float)amount;
- (void)heal:(float)amount;
- (void)showHealthBar;
- (void)hideHealthBar;

@end