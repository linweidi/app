//
//  CardMatchingGame.h
//  Machismo
//
//  Created by Linwei Ding on 6/13/15.
//  Copyright (c) 2015 Linwei Ding. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"
#import "Card.h"

@interface CardMatchingGame : NSObject

@property (nonatomic) BOOL matchMode; // 2-NO, 3-YES

//designated initializer
- (instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck;

- (void)chooseCardAtIndex:(NSUInteger)index;

- (Card *)cardAtIndex:(NSUInteger)index;


- (void) matchTwoCards: (Card *)card ;
- (void) matchThreeCards: (Card *)card ;

@property (nonatomic, readonly) NSInteger score;

@property (nonatomic) NSInteger indexSecCard;
@property (nonatomic) NSInteger indexThirdCard;

@end
