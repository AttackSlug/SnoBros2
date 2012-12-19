//
//  MainMenuViewController.m
//  SnoBros2
//
//  Created by Cjab on 12/18/12.
//  Copyright (c) 2012 Attack Slug. All rights reserved.
//

#import "MainMenuViewController.h"

@interface MainMenuViewController ()

@end

@implementation MainMenuViewController

- (id)initWithNibName:(NSString *)nibNameOrNil
               bundle:(NSBundle *)nibBundleOrNil {
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
  }
  return self;
}



- (void)viewDidLoad {
  [super viewDidLoad];
}



- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
}



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
  return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}



- (IBAction)touchStartGame:(id)sender {
  [[NSNotificationCenter defaultCenter] postNotificationName:@"showGameView"
                                                      object:self];
}

@end