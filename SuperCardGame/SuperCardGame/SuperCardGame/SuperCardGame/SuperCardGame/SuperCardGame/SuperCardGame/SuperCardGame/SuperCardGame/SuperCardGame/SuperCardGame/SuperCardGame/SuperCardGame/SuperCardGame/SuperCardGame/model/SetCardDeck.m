//
//  SetCardDeck.m
//  TryThisGame
//
//  Created by Linwei Ding on 6/18/15.
//  Copyright (c) 2015 Linwei Ding. All rights reserved.
//

#import "SetCardDeck.h"
#import "SetCard.h"



@implementation SetCardDeck

- (instancetype) init {
    self = [super init];
    
    if (self) {
        for (int i = 0; i< [SetCard maxRank]; i++){
            for ( NSString *shape in [SetCard validShape])  {
                for ( NSString *color in [SetCard validColor])  {
                    for ( NSString *pattern in [SetCard validPattern])  {
                        SetCard *card = [[SetCard alloc] init];
                        card.shape = shape;
                        card.rank = i;
                        card.color = color;
                        card.pattern = pattern;
                        [self addCard:card];
                    }
                }
                
            }
        }
        NSAssert([self.cards count] == 81, @"the count of deck cards is not 81, it is: %d", [self.cards count]);

    }
    
    return self;
}

@end
