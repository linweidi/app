//
//  TestViewController.h
//  MyApp
//
//  Created by Linwei Ding on 10/14/15.
//  Copyright © 2015 AppsFoundation. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "JTCalendar.h"

@interface TestViewController : UIViewController<JTCalendarDelegate>

@property (weak, nonatomic) IBOutlet JTCalendarMenuView *calendarMenuView;
@property (weak, nonatomic) IBOutlet JTHorizontalCalendarView *calendarContentView;

@property (strong, nonatomic) JTCalendarManager *calendarManager;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *calendarContentViewHeight;

@end

