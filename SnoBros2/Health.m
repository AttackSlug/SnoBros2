//
//  Health.m
//  SnoBros2
//
//  Created by Tanoy Sinha on 11/26/12.
//  Copyright (c) 2012 Cjab. All rights reserved.
//

#import "Health.h"

#import "Renderable.h"
#import "Entity.h"
#import "Sprite.h"

@implementation Health

- (id)initWithEntity:(Entity *)entity {
  self = [super initWithEntity:entity];
  if (self) {
  }
  return self;
}



- (id)initWithEntity:(Entity *)entity dictionary:(NSDictionary *)data {
  self = [self initWithEntity:entity];
  if (self) {
    NSString *spriteName    = [data valueForKey:@"spriteName"];
    Renderable *renderable  = [entity getComponentByString:@"Renderable"];
    
    healthBar_  = [renderable getSpriteByTag:spriteName];
    health_     = [[data valueForKey:@"health"] floatValue];
    
    [healthBar_ translate:GLKVector2Make(0, -(healthBar_.parent.height / 2.f))];
    [self hideHealthBar];
  }
  return self;
}



- (void)showHealthBar {
  healthBar_.visible = TRUE;
}



- (void)hideHealthBar {
  healthBar_.visible = FALSE;
}

@end
