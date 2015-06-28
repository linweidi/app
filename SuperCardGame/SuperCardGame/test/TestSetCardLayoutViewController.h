//
//  TestSetCardLayoutViewController.h
//  SuperCardGame
//
//  Created by Linwei Ding on 6/26/15.
//  Copyright (c) 2015 Linwei Ding. All rights reserved.
//

#import "Grid.h"
#import "CardMatchingGame.h"
#import "TestBasicCardLayoutViewController.h"
@interface TestSetCardLayoutViewController : TestBasicCardLayoutViewController

@property (strong, nonatomic) Grid * grid;

@property (strong, nonatomic) CardMatchingGame * game;

@end
