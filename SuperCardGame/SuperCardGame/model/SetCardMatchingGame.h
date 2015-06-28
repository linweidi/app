//
//  SetCardMatchingGame.h
//  SuperCardGame
//
//  Created by Linwei Ding on 6/26/15.
//  Copyright (c) 2015 Linwei Ding. All rights reserved.
//

#import "CardMatchingGame.h"

@interface SetCardMatchingGame : CardMatchingGame

- (instancetype)init;

- (Deck *) createDeck;

- (BOOL) dealThreeCards ;

+ (NSUInteger) initCardNumber;

- (NSUInteger) cardNumber;

- (NSUInteger) cardUnmatchedNumber;

@end
