//
//  ThreeCardMatchingGame.m
//  Machismo
//
//  Created by Linwei Ding on 6/14/15.
//  Copyright (c) 2015 Linwei Ding. All rights reserved.
//

#import "ThreeCardMatchingGame.h"
#import "PlayingCard.h"

@implementation ThreeCardMatchingGame

- (NSAttributedString *) convertToAttrForString:(NSString *)string {
    NSAttributedString * retString = nil;
    NSArray * symbolArray = [[PlayingCard validSuits] arrayByAddingObjectsFromArray:[PlayingCard rankStrings]];
    
    retString = [self convertToAttrForString:string ForTargetString:[symbolArray componentsJoinedByString:@""]];
    
    return retString;
}



@end
