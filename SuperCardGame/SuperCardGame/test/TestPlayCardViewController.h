//
//  PlayCardViewController.h
//  SuperCardGame
//
//  Created by Linwei Ding on 6/25/15.
//  Copyright (c) 2015 Linwei Ding. All rights reserved.
//
#import "PlayingCardView.h"
#import "PlayingCardDeck.h"
#import "PlayingCard.h"
#import <UIKit/UIKit.h>

@interface TestPlayCardViewController : UIViewController


@property (nonatomic,strong) PlayingCardView *cardView;
@property (strong, nonatomic) Deck *deck;
@property (weak, nonatomic) IBOutlet UIView *tableView;
@end
