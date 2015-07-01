//
//  ThreeCardMatchingGame.m
//  Machismo
//
//  Created by Linwei Ding on 6/14/15.
//  Copyright (c) 2015 Linwei Ding. All rights reserved.
//

#import "ThreeCardMatchingGame.h"

@implementation ThreeCardMatchingGame

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

- (NSString *) labelText {
    if (!_labelText) {
        _labelText = @"";
    }
    return _labelText;
}

- (void) chooseCardAtIndex:(NSUInteger)index{
    [super chooseCardAtIndex:index];
    
    [self updateLabelMatch:index];
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
                self.labelText = [NSString stringWithFormat:@"Matching: %@, %@",
                                  firstCard.contents, secCard.contents];
            }
            else if(matchTwo>=0 && matchThree>0) {
                self.labelText = [NSString stringWithFormat:@"Matching: %@, %@",
                                  secCard.contents, thirdCard.contents];
            }
            else if(matchOne > 0 && matchThree>0 ) {
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



@end
