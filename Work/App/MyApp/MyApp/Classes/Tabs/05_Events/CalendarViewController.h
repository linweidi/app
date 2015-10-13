//
//  CalendarViewController.h
//  MyApp
//
//  Created by Linwei Ding on 10/12/15.
//  Copyright (c) 2015 AppsFoundation. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TabTableViewController.h"

#import "JTCalendar.h"

@interface CalendarViewController : TabTableViewController<JTCalendarDelegate>

@property (weak, nonatomic) IBOutlet JTCalendarMenuView *calendarMenuView;
@property (weak, nonatomic) IBOutlet JTHorizontalCalendarView *calendarContentView;

@property (strong, nonatomic) JTCalendarManager *calendarManager;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *calendarContentViewHeight;


@end

