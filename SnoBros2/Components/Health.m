//
//  Health.m
//  SnoBros2
//
//  Created by Tanoy Sinha on 11/26/12.
//  Copyright (c) 2012 Attack Slug. All rights reserved.
//

#import "Health.h"

#import "Entity.h"
#import "SceneNode.h"
#import "SceneGraph.h"

@implementation Health

@synthesize health    = health_;
@synthesize maxHealth = maxHealth_;
@synthesize visible   = visible_;
@synthesize spriteName = spriteName_;

- (id)initWithEntity:(Entity *)entity {
  self = [super initWithEntity:entity];
  if (self) {
    NSString *takeDamage = [entity_.uuid stringByAppendingString:@"|takeDamage"];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(takeDamage:)
                                                 name:takeDamage
                                               object:nil];
  }
  return self;
}



- (id)initWithEntity:(Entity *)entity dictionary:(NSDictionary *)data {
  self = [self initWithEntity:entity];
  if (self) {
    spriteName_  = data[@"SpriteRef"];
    health_     = [data[@"Health"] floatValue];
    maxHealth_  = health_;
    visible_    = FALSE;
    
    [self hideHealthBar];
  }
  return self;
}



- (void)takeDamage:(NSNotification *)notification {
  int amount;
  [[notification userInfo][@"amount"] getValue:&amount];
  [self damage:amount];
}



- (void)damage:(float)amount {
  int prevHealth = health_;
  health_       -= amount;
  if (health_ < 0) { health_ = 0; }

  if (prevHealth > 0 && health_ == 0) {
    NSDictionary *destroyData = @{@"entity": entity_};
    [[NSNotificationCenter defaultCenter] postNotificationName:@"destroyEntity"
                                                        object:self
                                                      userInfo:destroyData];
    NSLog(@"DEAD!");
  }
}



- (void)heal:(float)amount {
  health_ += amount;
  if (health_ > maxHealth_) {
    health_ = maxHealth_;
  }
}



- (void)showHealthBar {
  visible_ = TRUE;
}



- (void)hideHealthBar {
  visible_ = FALSE;
}

@end