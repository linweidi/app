//
//  ThemeManager.m
//  Restaurants
//
//  Created by AppsFoundation on 1/26/15.
//  Copyright (c) 2015 AppsFoundation. All rights reserved.
//

#import "ThemeManager.h"
#import <UIKit/UIKit.h>

@interface ThemeManager()

@property (strong, nonatomic) UIColor * barColor;
@property (strong, nonatomic) UIColor * buttonColor;
@property (strong, nonatomic) UIColor * backgroundColor;
@end

@implementation ThemeManager

+ (ThemeManager *)sharedUtil {
    static dispatch_once_t predicate = 0;
    static ThemeManager *sharedObject;
    
    dispatch_once(&predicate, ^{
        //initializing singleton object
        sharedObject = [[self alloc] init];
        
        sharedObject.barColor = [UIColor colorWithRed:79.0/255.0 green:175.0/255.0 blue:182.0/255.0 alpha:1.0f];
        sharedObject.buttonColor = [UIColor colorWithRed:55.0/255.0 green:165.0/255.0 blue:172.0/255.0 alpha:1.0f];
        sharedObject.backgroundColor = [UIColor colorWithRed:225.0/255.0 green:237.00/255.0 blue:238.0/255.0 alpha:1.0f];
    });
    return sharedObject;
}

//- (void) applyTheme {
//    [self applyNavigationBarTheme];
//}

- (void)applyNavigationBarTheme {
    [[UINavigationBar appearance] setTitleTextAttributes: @{NSForegroundColorAttributeName: [UIColor whiteColor],
                NSFontAttributeName: [UIFont fontWithName:@"KozGoPro-Light" size:18.0f]}];
    
    
    [[UINavigationBar appearance] setBackgroundColor:self.barColor];
    //[[UIView appearance] setBackgroundColor:self.backgroundColor];
    [[UIButton appearance] setBackgroundColor:self.buttonColor];
    [[UIButton appearance] setTintColor:[UIColor whiteColor]];

//     self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background"]];
//     
//     [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"background"]
//                                                   forBarMetrics:UIBarMetricsDefault]; //UIImageNamed:@"transparent.png"UIImageNamed:@"transparent.png"
//     self.navigationController.navigationBar.translucent = YES;
//     self.navigationController.navigationBar.layer.shadowOpacity = 1.0f;
//     self.navigationController.navigationBar.layer.shadowRadius = 1.0f;
//     self.navigationController.navigationBar.layer.shadowOffset = CGSizeMake(1, 1);
//     
//     self.automaticallyAdjustsScrollViewInsets = NO;
    
}

@end
