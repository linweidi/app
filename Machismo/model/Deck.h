//
//  Deck.h
//  Machismo
//
//  Created by Linwei Ding on 6/4/15.
//  Copyright (c) 2015 Linwei Ding. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject


- (void)addCard:(Card *)card atTop:(BOOL)atTop;

- (void)addCard:(Card *)card;

- (Card *)drawRandomCard;

@end
