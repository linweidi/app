//
//  SetCard.m
//  TryThisGame
//
//  Created by Linwei Ding on 6/18/15.
//  Copyright (c) 2015 Linwei Ding. All rights reserved.
//

#import "SetCard.h"

@implementation SetCard

- (NSString *) contents {
    return self.shape;
}

- (void) setShape:(NSString *)shape {
    if([[SetCard validShape] containsObject:shape]) {
        _shape = shape;
    }
}

+ (NSArray *) validShape {
    return @[@"▲", @"●", @"■" ];
}

- (int) match: (NSArray *) otherCards {
    int score = 0;
    
    NSAssert( [otherCards count] == 1 || [otherCards count] == 2, @"count out of bound");
    
    if([otherCards count] == 1) {
        SetCard *otherCard = nil;
        id obj = [otherCards firstObject];
        if([obj isKindOfClass:[SetCard class]] ) {
            otherCard = (SetCard *)obj;
        }
        if(otherCard.shape == self.shape) {
            score = 4;
        }
    }
    else {
        // count is two
        SetCard * secCard = [otherCards firstObject];
        SetCard * thirdCard = [otherCards objectAtIndex:1];
        int matchOne = [self match: @[secCard]];
        int matchTwo = [self match:@[thirdCard]];
        int matchThird = [secCard match:@[thirdCard]];
        score = matchOne + matchTwo + matchThird;
    }
    
    return score;
}

@end
