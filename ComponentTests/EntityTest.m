//
//  EntityTest.m
//  Component
//
//  Created by Cjab on 11/1/12.
//  Copyright (c) 2012 Cjab. All rights reserved.
//

#import "EntityTest.h"
#import "Entity.h"
#import "Message.h"

@implementation EntityTest


- (void)setUp {
  [super setUp];
  // Set-up code here.
}



- (void)tearDown {
  // Tear-down code here.
  [super tearDown];
}



- (void)testShouldWork {
  Entity  *entity      = [[Entity  alloc] init];
  Message *testMessage = [[Message alloc] init];
  [entity receiveMessage:testMessage];
}

@end