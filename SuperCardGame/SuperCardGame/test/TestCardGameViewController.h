//
//  TestCardGameViewController.h
//  SuperCardGame
//
//  Created by Linwei Ding on 6/25/15.
//  Copyright (c) 2015 Linwei Ding. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TestPlayCardViewController.h"
#import "Grid.h"
#import "CardMatchingGame.h"

@interface TestCardGameViewController : TestPlayCardViewController
@property (strong, nonatomic) Grid * grid;

@property (strong, nonatomic) CardMatchingGame * game;

@end
