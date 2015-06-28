//
//  TestBasicCardLayoutViewController.h
//  SuperCardGame
//
//  Created by Linwei Ding on 6/27/15.
//  Copyright (c) 2015 Linwei Ding. All rights reserved.
//
#import "Grid.h"
#import "CardMatchingGame.h"


@interface TestBasicCardLayoutViewController : UIViewController
@property (strong, nonatomic) Grid * grid;

@property (strong, nonatomic) CardMatchingGame * game;
@property (weak, nonatomic) IBOutlet UIView *tableView;

#pragma mark -- Virtual Functions
- (void) updateCardView:(UIView *)view forCard:(Card *)card;
- (UIView *) createView:(CGRect)rect;
- (CardMatchingGame *) createGame;

@end

