//
//  SetCardMatchingGame.h
//  TryThisGame
//
//  Created by Linwei Ding on 6/18/15.
//  Copyright (c) 2015 Linwei Ding. All rights reserved.
//

#import "TextCardMatchingGame.h"

@interface SetCardMatchingGame : TextCardMatchingGame
- (NSAttributedString *) convertString:(NSString*)string;

- (NSAttributedString *) convertToAttrForString:(NSString *)string;
@end
