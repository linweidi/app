//
//  CardMatchingGame.m
//  Machismo
//
//  Created by Linwei Ding on 6/13/15.
//  Copyright (c) 2015 Linwei Ding. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame ()

@property (nonatomic, readwrite) NSInteger score;



@end

@implementation CardMatchingGame

- (NSMutableArray *) cards {
    if (!_cards) {
        _cards = [[NSMutableArray alloc] init];
        
    }
    return _cards;
}

- (NSMutableArray *)dealCards {
    if (!_dealCards) {
        _dealCards = [[NSMutableArray alloc] init];
    }
    return _dealCards;
}

- (instancetype)init {
    self = [super init];
    
    if (self) {
        
    }
    return self;
}

- (instancetype) initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck {
    self = [super init];
    
    if (self) {
        for (int i =0; i< count; i++) {
            Card *card = [deck drawRandomCard];
            if(card) {
                [self.cards addObject:card];
            }
            else {
                self = nil;
                break;
            }
            
        }
        
        self.deck = deck;
    }
    
    return self;
}

- (Deck *) createDeck {
    return nil;
}

//static const int MATCH_BONUS_TWO = 4;
//static const int MATCH_BONUS_THREE = 10;

- (Card *)cardAtIndex:(NSUInteger)index {
    NSAssert(index<[self.cards count], @"the input index is:%d",index);
    return self.cards[index];
}

static const int MISMATCH_PENALTY = 2;
static const int MATCH_BONUS = 4;
static const int COST_TO_CHOSEN = 1;

- (void) chooseCardAtIndex:(NSUInteger)index {
    Card *card = [self cardAtIndex:index];
    
    if (self.matchMode) {
        //three cards mode
        [self matchThreeCards:card];
    }
    else {
        //two cards mode

        [self matchTwoCards:card];
    }
}

- (NSUInteger) cardNumber {
    return [self.cards count];
}



- (void) matchTwoCards: (Card *)card {
    if(!card.isMatched) {
        if(card.isChosen) {
            card.chosen = NO;
        }
        else {
            // is not chosen
            self.indexSecCard = -1;
            for(Card* otherCard in self.cards) {
                if(otherCard.isChosen && !otherCard.isMatched) {
                    int matchScore = [card match:@[otherCard]];
                    if(matchScore) {
                        self.score += matchScore * MATCH_BONUS;
                        
                        //update both cards to matched
                        otherCard.matched = YES;
                        card.matched = YES;
                    }
                    else {
                        self.score -= MISMATCH_PENALTY;
                        otherCard.chosen = NO;
                    }
                    
                    //found the other chosen card, so break out
                    self.indexSecCard = [self.cards indexOfObject:otherCard];
                    break;
                    
                }
            }
            self.score -= COST_TO_CHOSEN;
            card.chosen = YES;
        }
    }
}

- (void) matchThreeCards: (Card *)card {
    Card * secCard = nil;
    Card * thirdCard = nil;
    
    if(!card.isMatched) {
        if(card.isChosen) {
            card.chosen = NO;
        }
        else {
            // is not chosen
            self.indexSecCard = -1;
            self.indexThirdCard = -1;
            for (int i = 0; i< [self.cards count]; i++) {
                secCard = self.cards[i];

                
                
                if(secCard.isChosen && !secCard.isMatched) {
                    // two cards match at least

                    self.indexSecCard = i;
                    
                    
                    for (int j = i+1; j<[self.cards count]; j++){
                        thirdCard = self.cards[j];
                        if (thirdCard.isChosen && !thirdCard.isMatched) {
                            
                            self.indexThirdCard = j;
                            
                            //matchh threed cards
                            int matchScore = [card match:@[secCard, thirdCard]];
                            if(matchScore) {
                                self.score += matchScore * MATCH_BONUS;
                                
                                //update both cards to matched
                                secCard.matched = YES;
                                thirdCard.matched = YES;
                                card.matched = YES;
                            }
                            else {
                                self.score -= MISMATCH_PENALTY;
                                secCard.chosen = NO;
                                thirdCard.chosen = NO;
                            }


                            
                            break;
                        }
                    }
                    break;
                }
            }


            card.chosen = YES;
            self.score -= COST_TO_CHOSEN;
            
        }
    }
}


@end
