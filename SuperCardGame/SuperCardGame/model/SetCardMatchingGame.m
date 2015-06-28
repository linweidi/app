//
//  SetCardMatchingGame.m
//  SuperCardGame
//
//  Created by Linwei Ding on 6/26/15.
//  Copyright (c) 2015 Linwei Ding. All rights reserved.
//

#import "SetCardDeck.h"
#import "SetCardMatchingGame.h"
#import "SetCard.h"

@implementation SetCardMatchingGame

static const int GAME_CARD_INIT_NUMBER = 12;
- (instancetype)init {
    self = [super init];
    
    if (self) {
        self = [super initWithCardCount:GAME_CARD_INIT_NUMBER usingDeck:[self createDeck]];
    }
    return self;
}

- (Deck *) createDeck {
    return [[SetCardDeck alloc] init];
}

- (BOOL) dealThreeCards  {
    BOOL ret = NO;
    NSMutableArray * threeCards = [[NSMutableArray alloc] init];
    [threeCards addObject:[self.deck drawRandomCard]];
    [threeCards addObject:[self.deck drawRandomCard]];
    [threeCards addObject:[self.deck drawRandomCard]];
    
    if ([threeCards count] == 3) {
        [self.cards addObjectsFromArray:threeCards];
        
        ret = YES;
    }
    
    return ret;
    
}

+ (NSUInteger) initCardNumber {
    return  GAME_CARD_INIT_NUMBER;
}

- (NSUInteger) cardNumber {
    return [self.cards count];
}

- (NSUInteger) cardUnmatchedNumber {
    NSUInteger count = 0;
    for (SetCard * card in self.cards) {
        if (!card.isMatched) {
            count++;
        }
    }
    return count;
}
@end
