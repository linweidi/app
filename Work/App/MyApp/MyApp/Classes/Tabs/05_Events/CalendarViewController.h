//
//  CalendarViewController.h
//  MyApp
//
//  Created by Linwei Ding on 10/12/15.
//  Copyright (c) 2015 AppsFoundation. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseCalendarViewController.h"

#import "JTCalendar.h"

@interface CalendarViewController : BaseCalendarViewController<UIActionSheetDelegate,JTCalendarDelegate>


//@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet JTCalendarMenuView *calendarMenuView;
@property (weak, nonatomic) IBOutlet JTHorizontalCalendarView *calendarContentView;

@property (strong, nonatomic) JTCalendarManager *calendarManager;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *calendarContentViewHeight;

@property (strong, nonatomic) UIRefreshControl * refreshControl;


@property (nonatomic) BOOL multiSelection;

//@property (strong, nonatomic) NSMutableArray * rightBarButtons;

@end

