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
        
        self.matchMode = YES;
    }
    return self;
}

- (Deck *) createDeck {
    return [[SetCardDeck alloc] init];
}

- (BOOL) dealThreeCards  {
    BOOL ret = NO;

    if ([self.deck.cards count] >= 3) {
        
        NSMutableArray * threeCards = [[NSMutableArray alloc] init];
        [threeCards addObject:[self.deck drawRandomCard]];
        [threeCards addObject:[self.deck drawRandomCard]];
        [threeCards addObject:[self.deck drawRandomCard]];
        
        if ([threeCards count] == 3) {
            [self.cards addObjectsFromArray:threeCards];
            
            ret = YES;
            
            //add into deal cards as property
            self.dealCards = threeCards;
        }
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

- (void)chooseCardAtIndex:(NSUInteger)index {
    [super chooseCardAtIndex:index];
    
    //remove matched cards in the game
    NSMutableArray * array = [[NSMutableArray alloc] init];
    NSMutableArray * indexArray = [[NSMutableArray alloc] init];
    
    int indexCard = 0;
    for (Card *card in self.cards) {
        if (card.matched) {
            [array addObject:card];
            [indexArray addObject:@(indexCard)];
            //[self.cards removeObject:card];
        }
        indexCard ++;
    }
    
    int i =0;
    for (Card *card in array) {
        //add to removed cards array
        [self addRemovedCard:card index:[(NSNumber *)(indexArray[i]) unsignedIntegerValue] ];
        
        [self.cards removeObject:card];
        
        i++;
    }
}

- (void) addRemovedCard:(Card *)card index:(NSUInteger)index{
    [self.removedCards addObject:card];
    NSNumber * value = @(index);
    [self.indexRemovedCards addObject:value];
}

- (void) removeRemovedCard:(Card *)card {
    int index = [self.removedCards indexOfObject:card];
    [self.removedCards removeObjectAtIndex:index];
    [self.indexRemovedCards removeObjectAtIndex:index];
}

- (NSMutableArray *)dealCards {
    if (!_dealCards) {
        _dealCards = [[NSMutableArray alloc] init];
    }
    return _dealCards;
}

- (NSMutableArray *)removedCards {
    if (!_removedCards) {
        _removedCards = [[NSMutableArray alloc]init];
    }
    return _removedCards;
}

- (NSMutableArray *)indexRemovedCards {
    if (!_indexRemovedCards) {
        _indexRemovedCards = [[NSMutableArray alloc] init];
    }
    return _indexRemovedCards;
}
@end
