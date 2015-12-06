//
//  ThemeManager.h
//  Restaurants
//
//  Created by AppsFoundation on 1/26/15.
//  Copyright (c) 2015 AppsFoundation. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface ThemeManager : NSObject

+ (ThemeManager *)sharedUtil;

//- (void)applyNavigationBarTheme;

- (void) applyTheme ;

@property (strong, nonatomic) UIColor * barColor;
@property (strong, nonatomic) UIColor * barColor2;
@property (strong, nonatomic) UIColor * buttonColor;
@property (strong, nonatomic) UIColor * backgroundColor;
@end
