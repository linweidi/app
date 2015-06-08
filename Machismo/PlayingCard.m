//
//  PlayingCard.m
//  Machismo
//
//  Created by Linwei Ding on 6/4/15.
//  Copyright (c) 2015 Linwei Ding. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

- (NSString *)contents {
    NSArray *rankStrings = @[@"?", @"A", @"2", @"3", @"4", @"5", @"6", @"7", @"8",
                             @"9", @"10", @"J", @"Q", @"K" ];
    return [NSString stringWithFormat:@"%d%@", self.rank, self.suit];
    
}

@end
