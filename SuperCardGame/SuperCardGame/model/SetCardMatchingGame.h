//
//  SetCardMatchingGame.h
//  SuperCardGame
//
//  Created by Linwei Ding on 6/26/15.
//  Copyright (c) 2015 Linwei Ding. All rights reserved.
//

#import "CardMatchingGame.h"

@interface SetCardMatchingGame : CardMatchingGame

@property (strong, nonatomic) NSMutableArray * dealCards ;
@property (strong, nonatomic) NSMutableArray * removedCards; //Card
@property (nonatomic) NSMutableArray  *indexRemovedCards; //NSUInteger
- (instancetype)init;

- (Deck *) createDeck;

- (BOOL) dealThreeCards ;

+ (NSUInteger) initCardNumber;

- (NSUInteger) cardNumber;

- (NSUInteger) cardUnmatchedNumber;

- (void)chooseCardAtIndex:(NSUInteger)index;

- (void) addRemovedCard:(Card *)card index:(NSUInteger)index;

- (void) removeRemovedCard:(Card *)card;
@end
