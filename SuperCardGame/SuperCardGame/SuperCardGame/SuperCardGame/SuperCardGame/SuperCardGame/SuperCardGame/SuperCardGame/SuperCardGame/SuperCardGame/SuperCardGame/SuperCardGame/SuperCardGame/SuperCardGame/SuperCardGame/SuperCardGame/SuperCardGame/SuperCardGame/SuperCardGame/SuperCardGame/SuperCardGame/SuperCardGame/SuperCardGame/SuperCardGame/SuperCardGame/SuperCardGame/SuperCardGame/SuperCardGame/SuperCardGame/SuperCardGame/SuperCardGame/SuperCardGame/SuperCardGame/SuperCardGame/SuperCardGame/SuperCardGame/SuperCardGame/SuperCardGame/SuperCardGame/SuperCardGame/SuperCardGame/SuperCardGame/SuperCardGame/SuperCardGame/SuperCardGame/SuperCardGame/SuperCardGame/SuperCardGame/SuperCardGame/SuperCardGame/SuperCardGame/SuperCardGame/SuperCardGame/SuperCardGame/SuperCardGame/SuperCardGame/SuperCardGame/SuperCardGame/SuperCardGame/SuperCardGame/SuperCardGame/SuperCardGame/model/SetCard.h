//
//  SetCard.h
//  SuperCardGame
//
//  Created by Linwei Ding on 6/26/15.
//  Copyright (c) 2015 Linwei Ding. All rights reserved.
//

#import "Card.h"

@interface SetCard : Card

@property (nonatomic, strong) NSString * shape;
@property (nonatomic) NSUInteger rank;
@property (nonatomic, strong) NSString * pattern;
@property (nonatomic, strong) NSString * color;

#pragma mark -- Valid Functions
+ (NSArray *) validShape ;
+ (NSArray *) validPattern ;
+ (NSArray *) validColor ;
+ (NSUInteger) maxRank;

- (int) match: (NSArray *) otherCards;


@end
