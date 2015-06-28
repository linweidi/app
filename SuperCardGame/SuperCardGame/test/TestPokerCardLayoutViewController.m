//
//  TestPokerCardLayoutViewController.m
//  SuperCardGame
//
//  Created by Linwei Ding on 6/26/15.
//  Copyright (c) 2015 Linwei Ding. All rights reserved.
//

#import "PokerCardMatchingGame.h"
#import "TableView.h"
#import "PlayingCard.h"
#import "PlayingCardView.h"
#import "TestPokerCardLayoutViewController.h"

@interface TestPokerCardLayoutViewController ()

@end

@implementation TestPokerCardLayoutViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- Gestures



/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

#pragma mark -- Others
- (UIView *) createView:(CGRect)rect {
    return [[PlayingCardView alloc]initWithFrame:rect];
}
- (CardMatchingGame *) createGame {
    return [[PokerCardMatchingGame alloc] init];
}

#pragma mark -- Update UI
- (void) updateCardView:(UIView *)view forCard:(Card *)card {
    PlayingCardView *playingCardView = nil;
    PlayingCard * playingCard  = nil;
    if ([view isKindOfClass:[PlayingCardView class]]) {
        playingCardView = (PlayingCardView * )view;
    }
    else {
        NSAssert(NO, @"view is not playing card view");
    }
    if ([card isKindOfClass:[PlayingCard class]]) {
        playingCard = (PlayingCard *)card;
    }
    if (card.isMatched) {
        playingCardView.suit = playingCard.suit;
        playingCardView.rank = playingCard.rank;
        playingCardView.faceUp = YES;
    }
    else {
        if (card.isChosen) {
            playingCardView.suit = playingCard.suit;
            playingCardView.rank = playingCard.rank;
            playingCardView.faceUp = YES;
        }
        else {
            playingCardView.suit = nil;
            playingCardView.rank = 0;
            playingCardView.faceUp = NO;
        }
    }
    
}



@end
