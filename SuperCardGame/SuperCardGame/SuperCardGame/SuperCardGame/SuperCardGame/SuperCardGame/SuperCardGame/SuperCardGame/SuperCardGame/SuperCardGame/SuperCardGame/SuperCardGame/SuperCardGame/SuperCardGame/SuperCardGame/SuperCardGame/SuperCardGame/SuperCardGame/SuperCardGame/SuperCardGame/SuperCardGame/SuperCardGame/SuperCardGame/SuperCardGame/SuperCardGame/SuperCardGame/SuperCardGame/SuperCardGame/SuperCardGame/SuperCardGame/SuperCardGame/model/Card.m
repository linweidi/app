//
//  Card.m
//  Machismo
//
//  Created by Linwei Ding on 6/4/15.
//  Copyright (c) 2015 Linwei Ding. All rights reserved.
//

#import "Card.h"
#import <Foundation/Foundation.h>

@interface Card()

@end

@implementation Card

- (int) match: (NSArray *) otherCards {
    int score = 0;
    
    for (Card *card in otherCards) {
        if ( [self.contents isEqualToString:card.contents]) {
            score = 1;
        }
    }
    
    return score;
}

@end