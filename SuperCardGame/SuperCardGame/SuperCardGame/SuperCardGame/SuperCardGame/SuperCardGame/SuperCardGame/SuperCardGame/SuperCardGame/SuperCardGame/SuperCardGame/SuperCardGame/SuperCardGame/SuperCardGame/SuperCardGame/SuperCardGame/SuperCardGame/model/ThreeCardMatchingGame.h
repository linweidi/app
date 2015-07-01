//
//  ThreeCardMatchingGame.h
//  Machismo
//
//  Created by Linwei Ding on 6/14/15.
//  Copyright (c) 2015 Linwei Ding. All rights reserved.
//

#import "CardMatchingGame.h"

@interface ThreeCardMatchingGame : CardMatchingGame

- (void) chooseCardAtIndex:(NSUInteger)index;

@property (nonatomic, strong) NSString * labelText;

//- (instancetype) initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck;

@end
