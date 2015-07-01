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

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
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

//- (IBAction)tap:(UITapGestureRecognizer *)sender {
//    CGPoint hitPoint = [sender locationInView:self.view];
//    UIView * view = [self.view hitTest:hitPoint withEvent:nil];
//    
//    
//    if (view) {
//        if ([view isKindOfClass:[CardView class]]) {
//            CardView *cardView = nil;
//            cardView = (CardView *)view;
//            
//            NSUInteger indexOfView = [(TableView *)self.tableView indexOfView:cardView ];
//            
//            //update the card
//            [self.game chooseCardAtIndex:indexOfView];
//            
//            //update the view
//            [self updateUI];
//            
//        }
//        else {
//            //none
//        }
//    }
//    
//}

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
    else {
        NSAssert(NO, @"card is not playing card");
    }
    
    
    if ((card.isMatched && !playingCardView.faceUp)
        || (!card.isMatched && ((card.isChosen && !playingCardView.faceUp) || (!card.isChosen && playingCardView.faceUp)))) {
        [UIView transitionWithView:playingCardView duration:1.0 options:UIViewAnimationOptionTransitionFlipFromLeft|
         UIViewAnimationOptionBeginFromCurrentState|
         UIViewAnimationOptionCurveEaseInOut animations:^{
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
         }completion:nil];
    }
    
    
    [self animateDealCardsForView:playingCardView card:playingCard];
    

    
    //animation
}



@end
