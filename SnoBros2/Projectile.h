//
//  Projectile.h
//  Component
//
//  Created by Cjab on 11/8/12.
//  Copyright (c) 2012 Cjab. All rights reserved.
//

#import "Behavior.h"

@interface Projectile : Behavior

- (void)walkTo:(GLKVector2)target;

@end
