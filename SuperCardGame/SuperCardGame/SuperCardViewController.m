//
//  SuperCardViewController.m
//  SuperCardGame
//
//  Created by Linwei Ding on 6/24/15.
//  Copyright (c) 2015 ___FULLUSERNAME___. All rights reserved.
//

#import "SuperCardViewController.h"


@interface SuperCardViewController ()

@property (weak, nonatomic) IBOutlet UIButton *redealButton;

@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;

@property (nonatomic, strong) CardMatchingGame * game;

@property (nonatomic, strong) Deck * deck;

@property (weak, nonatomic) IBOutlet UILabel *matchResult;

@end

@implementation SuperCardViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- internal function
//virtual method
- (Deck *)createDeck {
    NSAssert(NO, @"virtual function");
    return nil;
}

- (CardMatchingGame *) createMatchingGame {
    NSAssert(NO, @"virtual function");
    return nil;
}

#pragma mark -- action
- (IBAction)touchForRedeal:(UIButton *)sender {
    self.deck = [self createDeck];
    self.game = [self createMatchingGame];
    [self updateUI];
}

#pragma mark -- update ui
- (NSString *) titleForCard: (Card *)card {
    return card.isMatched?card.contents:card.isChosen?card.contents:@"";
}

- (UIImage *) backgroundImageForCard: (Card*)card {
    UIImage * imageFront = [UIImage imageNamed:@"cardfront"];
    UIImage * imageBack = [UIImage imageNamed:@"cardback"];
    return card.isMatched?imageFront:card.isChosen?imageFront:imageBack;
}

- (void) updateUI {
#ifdef DEBUG_CARD_VIEW
    for (UIButton *cardButton in self.cardButtons){
        int cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardButtonIndex];
        if(card) {
            [cardButton setTitle:[self titleForCard:card] forState:UIControlStateNormal];
            [cardButton setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];
            cardButton.enabled = !card.isMatched;
            
            [self.scoreLabel setText:[NSString stringWithFormat:@"Score: %d", self.game.score]];
        }
        
        
    }

    self.matchResult.text = self.game.labelText;
#endif
}

#pragma mark -- dynamic animation


@end
