//
//  TextCardMatchingGame.h
//  TryThisGame
//
//  Created by Linwei Ding on 6/18/15.
//  Copyright (c) 2015 Linwei Ding. All rights reserved.
//

#import "CardMatchingGame.h"

@interface TextCardMatchingGame : CardMatchingGame

- (void) chooseCardAtIndex:(NSUInteger)index;

@property (nonatomic, strong) NSString * labelText;

//- (instancetype) initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck;

@property (nonatomic, strong) NSMutableArray * textArray;

@property (strong, nonatomic) NSMutableArray * matchHistory;

- (NSAttributedString *) convertToAttrForString:(NSString *)string;

- (NSAttributedString *) convertToAttrForString:(NSString *)string
                              ForTargetString:(NSString *)targetStr;

@end
