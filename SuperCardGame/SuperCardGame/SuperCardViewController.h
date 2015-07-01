//
//  SuperCardViewController.h
//  SuperCardGame
//
//  Created by Linwei Ding on 6/24/15.
//  Copyright (c) 2015 ___FULLUSERNAME___. All rights reserved.
//
#import "Grid.h"
#import "CardMatchingGame.h"
#import <UIKit/UIKit.h>


@interface SuperCardViewController : UIViewController



@property (strong, nonatomic) Grid * grid;

@property (strong, nonatomic) CardMatchingGame * game;
//@property (weak, nonatomic) IBOutlet UIView *tableView;

@property (weak, nonatomic) IBOutlet TableView *tableView;

@property (weak, nonatomic) IBOutlet UIButton *redealButton;

- (void) updateUI;

- (void)animateDealCardsForView: (CardView *)view card:(Card*)card;


#pragma mark -- Virtual Functions
- (void) updateCardView:(UIView *)view forCard:(Card *)card;
- (UIView *) createView:(CGRect)rect;
- (CardMatchingGame *) createGame;

#pragma mark -- Gestures
- (IBAction)tap:(UITapGestureRecognizer *)sender;



- (IBAction)touchForRedeal:(UIButton *)sender;

@end
