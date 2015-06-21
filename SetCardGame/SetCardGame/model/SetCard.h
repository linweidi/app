//
//  SetCard.h
//  TryThisGame
//
//  Created by Linwei Ding on 6/18/15.
//  Copyright (c) 2015 Linwei Ding. All rights reserved.
//

#import "Card.h"

@interface SetCard : Card

@property (nonatomic, strong) NSString * shape;

+ (NSArray *) validShape ;

@end
