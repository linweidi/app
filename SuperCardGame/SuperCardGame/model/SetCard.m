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
+ (BOOL) matchOneAspect:(NSString *)first two:(NSString*)second three:(NSString *)third {
    NSAssert(first!=nil&& second!=nil && third!=nil, @"the input is nil");
    BOOL valid = NO;
    
    BOOL validOne = [first isEqualToString:second];
    BOOL validTwo = [second isEqualToString:third];
    BOOL validThree = [first isEqualToString:third];
    if ((validOne && validTwo && validThree)
        || (!validOne && !validTwo && !validThree)) {
        valid = YES;
    }
    else {
        valid = NO;
    }
    return valid;
}

+ (BOOL) matchOneAspectInt:(NSUInteger)first two:(NSUInteger)second three:(NSUInteger)third {
    NSAssert(first<3&& second<3&& third<3, @"the input is greater than or equal to 3");
    BOOL valid = NO;
    
    BOOL validOne = (first == second);
    BOOL validTwo = (second == third);
    BOOL validThree = (first == third);
    if ((validOne && validTwo && validThree)
        || (!validOne && !validTwo && !validThree)) {
        valid = YES;
    }
    else {
        valid = NO;
    }
    return valid;
}

- (int) match: (NSArray *) otherCards {
    int score = 0;
    BOOL valid = YES;
    
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
        
        valid = YES;
        if ([SetCard matchOneAspectInt:self.rank two:secCard.rank three:thirdCard.rank]) {
        }
        else {
            valid = NO;
        }
        if ([SetCard matchOneAspect:self.shape two:secCard.shape three:thirdCard.shape]) {
        }
        else {
            valid = NO;
        }
        if ([SetCard matchOneAspect:self.color two:secCard.color three:thirdCard.color]) {
        }
        else {
            valid = NO;
        }
        if ([SetCard matchOneAspect:self.pattern two:secCard.pattern three:thirdCard.pattern]) {
        }
        else {
            valid = NO;
        }
        
        if (valid) {
            //satisfy the set card match condition
            score = 4;
        }
        else {
            score = 0;
        }
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
