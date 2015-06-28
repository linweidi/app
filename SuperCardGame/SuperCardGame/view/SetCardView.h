//
//  SetCardView.h
//  SuperCardGame
//
//  Created by Linwei Ding on 6/27/15.
//  Copyright (c) 2015 Linwei Ding. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SetCardView : UIView


// when rank is 0, it is nil
@property (nonatomic, strong) NSString * shape;
@property (nonatomic) NSUInteger rank;
@property (nonatomic, strong) NSString * pattern;
@property (nonatomic, strong) NSString * color;
@property (nonatomic) BOOL shade;




@end
