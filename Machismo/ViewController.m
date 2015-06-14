//
//  ViewController.m
//  Machismo
//
//  Created by Linwei Ding on 6/4/15.
//  Copyright (c) 2015 Linwei Ding. All rights reserved.
//

#import "PlayingCardDeck.h"
#import "ViewController.h"
#import "CardMatchingGame.h"
#import "PlayingCard.h"

@interface ViewController ()

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;


@property (nonatomic) int flipCount;
@property (nonatomic, strong) Deck * deck;
@property (nonatomic, strong) CardMatchingGame * game;

@end

@implementation ViewController



- (CardMatchingGame *) game {
    if(!_game) {
        _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count] usingDeck:[self createDeck]];
    }
    
    return _game;
}

- (IBAction)touchCardButton:(UIButton *)sender {
    /*
    if([sender.currentTitle length]) {
        [sender setBackgroundImage:[UIImage imageNamed:@"cardback"]
                          forState:UIControlStateNormal];
        [sender setTitle:@"" forState:UIControlStateNormal];
    }
    else {
        [sender setBackgroundImage:[UIImage imageNamed:@"cardfront"]
                          forState:UIControlStateNormal];
        [sender setTitle:@"A♣︎" forState:UIControlStateNormal];
    }
    
    self.flipCount++;
     */
//    if([sender.currentTitle length]) {
//        [sender setBackgroundImage:[UIImage imageNamed:@"cardback"]
//                          forState:UIControlStateNormal];
//        [sender setTitle:@"" forState:UIControlStateNormal];
//    }
//    else {
//
//        Card * card = [self.deck drawRandomCard];
//        if(card) {
//            [sender setBackgroundImage:[UIImage imageNamed:@"cardfront"]
//                              forState:UIControlStateNormal];
//            [sender setTitle:card.contents forState:UIControlStateNormal];
//            self.flipCount++;
//        }
//
//    }
    int chosenButtonIndex = [self.cardButtons indexOfObject:sender];
    
    [self.game chooseCardAtIndex:chosenButtonIndex];
    //Card  * card = [self.game cardAtIndex:chosenButtonIndex];
    
    [self updateUI];
//    if(card) {
//        if(card.isMatched) {
//            UIImage *image = [UIImage imageNamed:@"cardfront"];
//            [sender setBackgroundImage:image forState:UIControlStateNormal];
//            [sender setTitle:card.contents forState:UIControlStateNormal];
//        }
//        else {
//            if(card.isChosen) {
//                UIImage *image = [UIImage imageNamed:@"cardfront"];
//                [sender setBackgroundImage:image forState:UIControlStateNormal];
//                [sender setTitle:card.contents forState:UIControlStateNormal];
//            }
//            else {
//                UIImage *image = [UIImage imageNamed:@"cardback"];
//                [sender setBackgroundImage:image forState:UIControlStateNormal];
//                [sender setTitle:@"" forState:UIControlStateNormal];
//            }
//        }
//        
//    }
    
}

- (void) updateUI {
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
}

- (NSString *) titleForCard: (Card *)card {
    return card.isMatched?card.contents:card.isChosen?card.contents:@"";
}

- (UIImage *) backgroundImageForCard: (Card*)card {
    UIImage * imageFront = [UIImage imageNamed:@"cardfront"];
    UIImage * imageBack = [UIImage imageNamed:@"cardback"];
    return card.isMatched?imageFront:card.isChosen?imageFront:imageBack;
}


- (Deck *)createDeck {
    return [[PlayingCardDeck alloc] init];
}

@end
