//
//  SetCard.m
//  SuperCardGame
//
//  Created by Linwei Ding on 6/26/15.
//  Copyright (c) 2015 Linwei Ding. All rights reserved.
//

#import "SetCard.h"

@implementation SetCard

#pragma mark -- Properties
- (NSString *) contents {
    return [NSString stringWithFormat:@"%d %@ %@ %@",
            self.rank,self.shape,self.pattern,self.color];
}

//@synthesize shape = _shape;

- (void) setShape:(NSString *)shape {
    if([[SetCard validShape] containsObject:shape]) {
        _shape = shape;
    }
    else {
        NSAssert(NO, @"the shape is not valid");
    }
}

- (void)setRank:(NSUInteger)rank {
    if (rank <= [SetCard maxRank]) {
        _rank = rank;
    }
}

- (void)setPattern:(NSString *)pattern {
    if([[SetCard validPattern] containsObject:pattern]) {
        _pattern = pattern;
    }
    else {
        NSAssert(NO, @"the pattern is not valid");
    }
}

- (void)setColor:(NSString *)color {
    if([[SetCard validColor] containsObject:color]) {
        _color = color;
    }
    else {
        NSAssert(NO, @"the color is not valid");
    }
}


#pragma mark -- Functions
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

static const NSUInteger MAX_RANK = 3;

+ (NSUInteger) maxRank {
    return MAX_RANK;
}

+ (NSArray *) validShape {
    return @[@"squiggles", @"diamonds", @"ovals" ];
}

+ (NSArray *) validPattern  {
    return @[@"solid", @"striped", @"unfilled" ];
}
+ (NSArray *) validColor {
    return @[@"red", @"green", @"purple" ];
}


@end
