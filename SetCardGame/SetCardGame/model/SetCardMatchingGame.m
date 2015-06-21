//
//  SetCardMatchingGame.m
//  TryThisGame
//
//  Created by Linwei Ding on 6/18/15.
//  Copyright (c) 2015 Linwei Ding. All rights reserved.
//

#import "SetCardMatchingGame.h"
#import "SetCard.h"

@implementation SetCardMatchingGame
- (NSAttributedString *) convertString:(NSString *)string {
    NSAttributedString * retString = nil;
    if(string) {
    
        retString = [[NSAttributedString alloc] initWithString:string
                       attributes:
                     @{NSForegroundColorAttributeName:[UIColor redColor],
                       NSStrokeWidthAttributeName:@-3,
                       NSStrokeColorAttributeName:[UIColor grayColor],
                       NSShadowAttributeName:[[NSShadow alloc] init]}
                       ];
    }
    else {
        retString = [[NSAttributedString alloc] initWithString:@"" attributes:nil];
    }
    return retString;
}

- (NSAttributedString *) convertToAttrForString:(NSString *)string {
    NSAttributedString * retString = nil;
    
    retString = [self convertToAttrForString:string ForTargetString:[[SetCard validShape] componentsJoinedByString:@""]];
    
    return retString;
}

@end
