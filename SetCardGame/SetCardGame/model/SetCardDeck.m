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

static const int SET_CARD_NUM = 52;

- (instancetype) init {
    self = [super init];
    
    if (self) {
        for (int i = 0; i< SET_CARD_NUM; i++){
            for ( NSString *shape in [SetCard validShape])  {
                
                SetCard *card = [[SetCard alloc] init];
                card.shape = shape;
                [self addCard:card];
                
            }
        }

    }
    
    return self;
}

@end
