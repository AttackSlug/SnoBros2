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
    NSString *spriteName    = data[@"spriteName"];
    SceneGraph *sceneGraph  = [entity getComponentByString:@"SceneGraph"];
    
    healthBar_  = [sceneGraph getNodeByName:@"HealthBar"];
    health_     = [data[@"health"] floatValue];
    maxHealth_  = health_;
    
    [healthBar_ translate:GLKVector2Make(0, -20)];
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

  //[healthBar_ cropByPercent:(health_/maxHealth_)];
}



- (void)heal:(float)amount {
  health_ += amount;
  if (health_ > maxHealth_) {
    health_ = maxHealth_;
  }
  //[healthBar_ cropByPercent:(health_/maxHealth_)];
}



- (void)showHealthBar {
  healthBar_.visible = TRUE;
}



- (void)hideHealthBar {
  healthBar_.visible = FALSE;
}

@end