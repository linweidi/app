//
//  SetCardView.h
//  SuperCardGame
//
//  Created by Linwei Ding on 6/27/15.
//  Copyright (c) 2015 Linwei Ding. All rights reserved.
//
#import "CardView.h"
#import <UIKit/UIKit.h>

@interface SetCardView : CardView


@property (nonatomic, strong) NSString * shape;
@property (nonatomic) NSUInteger rank;
@property (nonatomic, strong) NSString * pattern;
@property (nonatomic, strong) NSString * color;
@property (nonatomic) BOOL shade;

@end
