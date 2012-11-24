//
//  Entity.m
//  Component
//
//  Created by Cjab on 11/1/12.
//  Copyright (c) 2012 Cjab. All rights reserved.
//

#import "Entity.h"

#import "EventManager.h"

#import "Transform.h"
#import "Renderer.h"
#import "Physics.h"
#import "Behavior.h"
#import "Collision.h"

@implementation Entity

@synthesize uuid        = uuid_;
@synthesize tag         = tag_;
@synthesize sprite      = sprite_;

@synthesize transform   = transform_;
@synthesize renderer    = renderer_;
@synthesize physics     = physics_;
@synthesize behavior    = behavior_;
@synthesize collision   = collision_;
@synthesize selectable  = selectable_;

@synthesize components  = components_;

- (id)init {
  return [self initWithTag:@"untagged" eventManager:nil];
}



- (id)initWithTag:(NSString *)tag {
  return [self initWithTag:tag eventManager:nil];
}



- (id)initWithTag:(NSString *)tag eventManager:(EventManager *)eventManager {
  self = [super init];
  if (self) {
    tag_ = tag;
    CFUUIDRef uuid = CFUUIDCreate(NULL);
    uuid_ = (__bridge_transfer NSString *)CFUUIDCreateString(NULL, uuid);
    CFRelease(uuid);
    eventManager_ = eventManager;
    components_ = [[NSMutableDictionary alloc] init];
  }
  return self;
}



- (void)update {
  for (id key in components_) {
    [[components_ objectForKey:key] update];
  }
}



- (void)renderWithCamera:(Camera*)camera interpolationRatio:(double)ratio {
  [renderer_ renderWithCamera:camera interpolationRatio:ratio];
}



- (void)sendEvent:(Event *)event {
  [eventManager_ addEvent:event];
}



- (void)receiveEvent:(Event *)event {
  for (id key in components_) {
    [[components_ objectForKey:key] receiveEvent:event];
  }
}



- (id)getComponentByString:(NSString *)string {
  return [components_ objectForKey:string];
}



- (void)setComponent:(Component *)component withString:(NSString *)string {
  [components_ setObject:component forKey:string];
}

@end
