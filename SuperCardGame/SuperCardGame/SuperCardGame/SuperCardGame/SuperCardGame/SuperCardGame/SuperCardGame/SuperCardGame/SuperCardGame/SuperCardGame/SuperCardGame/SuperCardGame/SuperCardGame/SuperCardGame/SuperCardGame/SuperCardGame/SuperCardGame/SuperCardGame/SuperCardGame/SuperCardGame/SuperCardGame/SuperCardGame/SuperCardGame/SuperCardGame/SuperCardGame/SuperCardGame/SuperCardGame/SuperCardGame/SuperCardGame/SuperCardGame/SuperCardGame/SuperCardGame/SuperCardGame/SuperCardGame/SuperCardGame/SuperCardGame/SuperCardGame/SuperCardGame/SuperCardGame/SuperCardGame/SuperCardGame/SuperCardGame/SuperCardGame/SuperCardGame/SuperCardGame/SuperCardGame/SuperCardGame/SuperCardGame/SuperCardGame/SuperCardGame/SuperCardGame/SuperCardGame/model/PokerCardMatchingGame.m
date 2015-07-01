//
//  PokerCardMatchingGame.m
//  SuperCardGame
//
//  Created by Linwei Ding on 6/26/15.
//  Copyright (c) 2015 Linwei Ding. All rights reserved.
//

#import "PlayingCardDeck.h"
#import "PokerCardMatchingGame.h"

@implementation PokerCardMatchingGame

static const int GAME_CARD_NUMBER = 15;

- (instancetype)init {
    self = [super init];
    
    if (self) {
        self = [super initWithCardCount:GAME_CARD_NUMBER usingDeck:[self createDeck]];
    }
    return self;
}

- (Deck *) createDeck {
    return [[PlayingCardDeck alloc] init];
}

+ (NSUInteger) initCardNumber {
    return GAME_CARD_NUMBER;
}

@end
