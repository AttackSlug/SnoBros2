//
//  Physics.m
//  Component
//
//  Created by Cjab on 11/1/12.
//  Copyright (c) 2012 Cjab. All rights reserved.
//

#import "Physics.h"
#import "Transform.h"

@implementation Physics


- (id)initWithEntity:(Entity *)entity {
  return [super initWithEntity:entity];
}



- (void)update {
  Transform *transform = (Transform *)[entity_ componentWithName:@"transform"];
  [transform translate:velocity_];
}

@end