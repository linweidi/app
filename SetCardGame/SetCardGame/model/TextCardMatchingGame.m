//
//  TextCardMatchingGame.m
//  TryThisGame
//
//  Created by Linwei Ding on 6/18/15.
//  Copyright (c) 2015 Linwei Ding. All rights reserved.
//

#import "TextCardMatchingGame.h"

@implementation TextCardMatchingGame
//- (instancetype) initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck {
//
//    self = [super initWithCardCount:count usingDeck:deck];
//
//    if(self) {
//
//    }
//
//    return self;
//}

@synthesize labelText = _labelText;

- (NSString *) labelText {
    if (!_labelText) {
        _labelText = @"";
    }
    return _labelText;
}

- (void) setLabelText:(NSString *)labelText {
    _labelText = labelText;
    if (labelText && ![labelText isEqualToString:@""]) {
        [self storeLabelText];
    }
}

- (NSMutableArray *) matchHistory {
    if(!_matchHistory) {
        _matchHistory = [[NSMutableArray alloc]init];
    }
    return _matchHistory;
}

- (void) chooseCardAtIndex:(NSUInteger)index{
    [super chooseCardAtIndex:index];
    
    [self updateLabelMatch:index];
}

static const int MAX_ARRAY_NUM = 10;

- (NSMutableArray *) textArray {
    if(!_textArray) {
        _textArray = [[NSMutableArray alloc] init];
        
        for(int i=0; i< MAX_ARRAY_NUM; i++) {
            [_textArray addObject:@"No Record!"];
        }
        
    }
    return _textArray;
}


- (void) storeLabelText {
    [self.textArray addObject:self.labelText];
    if([self.textArray count]>MAX_ARRAY_NUM){
        for(int i=0; i<MAX_ARRAY_NUM; i++) {
            self.textArray[i] = self.textArray[i+1];
        }
        [self.textArray removeLastObject];
    }
    
    [self.matchHistory addObject:self.labelText];
}

- (void) updateLabelMatch: (NSUInteger)index {
    
    Card * firstCard = [self cardAtIndex:index];
    
    if( self.matchMode) {
        //three
        
        if( self.indexSecCard>=0 && self.indexThirdCard>=0) {
            
            Card * secCard = [self cardAtIndex:self.indexSecCard];
            Card * thirdCard = [self cardAtIndex:self.indexThirdCard];
            int matchOne = [firstCard match:@[secCard]];
            
            int matchTwo = [secCard match:@[thirdCard]];
            int matchThree = [firstCard match:@[thirdCard]];
            
            if(matchOne > 0 && matchTwo>0 && matchThree>0) {
                self.labelText = [NSString stringWithFormat:@"Matching: %@, %@, %@",
                                  firstCard.contents, secCard.contents, thirdCard.contents];
            }
            else if(matchOne > 0 && matchTwo>0 ) {
                self.labelText = [NSString stringWithFormat:@"Matching: %@, %@ && %@, %@",
                                  firstCard.contents, secCard.contents, secCard.contents, thirdCard.contents];
            }
            else if(matchTwo>0 && matchThree>0) {
                self.labelText = [NSString stringWithFormat:@"Matching: %@, %@ && %@, %@",
                                  secCard.contents, thirdCard.contents, firstCard.contents, thirdCard.contents];
            }
            else if(matchOne > 0 && matchThree>0 ) {
                self.labelText = [NSString stringWithFormat:@"Matching: %@, %@ && %@, %@",
                                  firstCard.contents, secCard.contents, firstCard.contents, thirdCard.contents];
            }
            else if(matchOne > 0 ) {
                self.labelText = [NSString stringWithFormat:@"Matching: %@, %@",
                                  firstCard.contents, secCard.contents];
            }
            else if(matchTwo>0 ) {
                self.labelText = [NSString stringWithFormat:@"Matching: %@, %@",
                                  secCard.contents, thirdCard.contents];
            }
            else if( matchThree>0 ) {
                self.labelText = [NSString stringWithFormat:@"Matching: %@, %@",
                                  firstCard.contents, thirdCard.contents];
            }
            else {
                self.labelText = [NSString stringWithFormat:@"No Match, select: %@",
                                  firstCard.contents];
            }
        }
        else {
            if(self.indexSecCard >=0) {
                Card * secCard = [self cardAtIndex:self.indexSecCard];
                int matchTwo = [firstCard  match:@[secCard]];
                if(matchTwo) {
                    self.labelText = [NSString stringWithFormat:@"select: %@, %@",
                                      firstCard.contents, secCard.contents];
                }
                else {
                    self.labelText = [NSString stringWithFormat:@"No Match:select: %@",
                                      firstCard.contents];
                }
                
            }
            else {
                self.labelText = [NSString stringWithFormat:@"select: %@",
                                  firstCard.contents];
            }
            
        }
    }
    else {
        
        Card * firstCard = [self cardAtIndex:index];
        if(self.indexSecCard >=0) {
            
            Card * secCard = [self cardAtIndex:self.indexSecCard];
            int matchOne = [firstCard match:@[secCard]];
            if(matchOne>0) {
                self.labelText = [NSString stringWithFormat:@"Matching: %@, %@",
                                  firstCard.contents, secCard.contents];
            }
            else {
                self.labelText = [NSString stringWithFormat:@"No Match, select: %@",
                                  firstCard.contents];
            }
        }
        else {
            self.labelText = [NSString stringWithFormat:@"select: %@",
                              firstCard.contents];
        }
    }
}

- (NSAttributedString *) convertToAttrForString:(NSString *)string {
    NSAssert(NO, @"virtual function");
    return nil;
}

- (NSAttributedString *) convertToAttrForString:(NSString *)string
                              ForTargetString:(NSString *)targetStr {
    NSMutableAttributedString * retString = nil;
    
    NSCharacterSet *charSet = [NSCharacterSet characterSetWithCharactersInString:targetStr];
    
    retString = [[NSMutableAttributedString alloc] initWithString:string];
    
    NSLog(@"%@", charSet.description);
    
    NSRange rangeStr;
    NSRange range;
    rangeStr.length = [string length];
    rangeStr.location = 0;
    while (YES) {
        range = [string rangeOfCharacterFromSet:charSet
                                        options:NSCaseInsensitiveSearch
                                          range:rangeStr];
        if(range.location == NSNotFound) {
            break;
        }else {
            rangeStr.location = range.location + 1;
            rangeStr.length = [string length] - range.location - 1 ;
            [retString addAttributes:@{NSForegroundColorAttributeName:[UIColor redColor],
                                       NSStrokeWidthAttributeName:@-3,
                                       NSStrokeColorAttributeName:[UIColor grayColor],
                                       NSShadowAttributeName:[[NSShadow alloc] init]} range:range];
            
        }
    }
    
    
    
    
    return retString;
}


@end
