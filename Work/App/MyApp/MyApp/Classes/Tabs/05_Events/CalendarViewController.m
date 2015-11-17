//
//  CalendarViewController.m
//  MyApp
//
//  Created by Linwei Ding on 10/12/15.
//  Copyright (c) 2015 AppsFoundation. All rights reserved.
//
//


// multiple secltions

#import <Parse/Parse.h>
#import "ProgressHUD.h"
#import <UIKit/UIKit.h>

#import "common.h"

#import "AppHeader.h"
#import "Event+Util.h"
#import "EventRemoteUtil.h"
#import "EventCellView.h"
#import "EventSettingsView.h"
#import "CalendarViewController.h"

@interface CalendarViewController (){
    NSMutableDictionary *_eventsByDate;
    

    
    NSMutableArray *_datesSelected;
    
    //NSDate *_datesSelectedLast;
    
//    UIBarButtonItem * buttonToday;
    UIBarButtonItem * _buttonMulti;
    
    NSDate * _currentDate;
}



//@property (strong, nonatomic)     NSMutableArray * eventDates;    //of NSDate
@end

@implementation CalendarViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if(self){
		[self.tabBarItem setImage:[UIImage imageNamed:@"tab_recents"]];
		self.tabBarItem.title = @"Events";
        self.title = @"Events";
    }
    
    
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Events";
    
    _calendarManager = [JTCalendarManager new];
    _calendarManager.delegate = self;
    
    NSMutableArray * rightBarButtons = [[NSMutableArray alloc] init];
    
    // add compose button
//    [rightBarButtons addObject:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(actionNew)]];
    // add compose button
    [rightBarButtons addObject:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(didCreateEventTouch)]];
    
    [rightBarButtons addObject:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemBookmarks target:self action:@selector(didChangeModeTouch)]];
    // add today button
    [rightBarButtons addObject:[[UIBarButtonItem alloc] initWithTitle:@"TODAY" style:UIBarButtonItemStyleBordered target:self action:@selector(didGoTodayTouch)]];

    _buttonMulti =[[UIBarButtonItem alloc] initWithTitle:@"MULTI" style:UIBarButtonItemStyleBordered target:self action:@selector(didChangeSelectModeTouch)];
    [rightBarButtons addObject:_buttonMulti];
    // add switch view button
    self.navigationItem.rightBarButtonItems = rightBarButtons;
    
    _multiSelection = NO;
    
    _currentDate = [NSDate date];
    
    // Generate random events sort by date using a dateformatter for the demonstration
    [self createRandomEvents];
    
//    _calendarMenuView.contentRatio = .75;
//    _calendarManager.settings.weekDayFormat = JTCalendarWeekDayFormatSingle;
//    _calendarManager.dateHelper.calendar.locale = [NSLocale localeWithLocaleIdentifier:@"fr_FR"];
    
    [_calendarManager setMenuView:_calendarMenuView];
    [_calendarManager setContentView:_calendarContentView];
    [_calendarManager setDate:[NSDate date]];
    
    _datesSelected = [NSMutableArray new];
    
    //_datesSelectedLast = [NSDate date];
    

    [self.tableView registerNib:[UINib nibWithNibName:@"EventCellView" bundle:nil] forCellReuseIdentifier:@"EventCell"];
    //---------------------------------------------------------------------------------------------------------------------------------------------
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(loadEvents) forControlEvents:UIControlEventValueChanged];
    
    [self.tableView addSubview:self.refreshControl];
}

- (void)viewDidAppear:(BOOL)animated
{
	[super viewDidAppear:animated];
    
    if ([[ConfigurationManager sharedManager] getCurrentUser] != nil) {
        [self loadEvents];

    }
    else {
        LoginUser(self);
    }
	
}

#pragma mark -- private method

- (void)loadEvents {

    if (self.managedObjectContext) {
        
#ifdef REMOTE_MODE
        Event * latestEvent = nil;
        
        latestEvent = [Event latestEntity:self.managedObjectContext];
        
        [[EventRemoteUtil sharedUtil] loadRemoteEvents:latestEvent completionHandler:^(NSArray *objects, NSError *error) {
            if (error == nil) {
                //[events removeAllObjects];
                //[events addObjectsFromArray:objects];
                //[self.tableView reloadData];
                
                // load the recents into core data
                
                [self.tableView reloadData];
                
            }
            else {
                [ProgressHUD showError:@"Network error."];
            }
            [self.refreshControl endRefreshing];
        }];
#endif
#ifdef LOCAL_MODE
        [self.tableView reloadData];
        [self.refreshControl endRefreshing];
#endif
    }

}


- (void)updateFetchedResultsController {
    
    if (self.managedObjectContext) {
        // init fetch request
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Event"];
        if (self.multiSelection) {
            request.predicate = [NSPredicate predicateWithFormat:@"startDay IN %@", _datesSelected];
        }
        else {
            request.predicate = [NSPredicate predicateWithFormat:@"startDay = %@", _currentDate];        }

        request.fetchLimit = EVENTVIEW_ITEM_NUM;
        request.sortDescriptors = @[[NSSortDescriptor
                                     sortDescriptorWithKey:@"startTime"
                                     ascending:NO
                                     selector:@selector(compare:)],
                                    ];
        
        
        // init fetch result controller
        /// TODO change section name
        self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request
                                                                            managedObjectContext:self.managedObjectContext
                                                                              sectionNameKeyPath:nil
                                                                                       cacheName:nil];
    }
}

#pragma mark - Buttons callback

- (IBAction)didCreateEventTouch
{
    
}

- (IBAction)didGoTodayTouch
{
    [_calendarManager setDate:[NSDate date]];
}

- (IBAction)didChangeModeTouch
{
    _calendarManager.settings.weekModeEnabled = !_calendarManager.settings.weekModeEnabled;
    [_calendarManager reload];
    
    CGFloat newHeight = 300;
    if(_calendarManager.settings.weekModeEnabled){
        newHeight = 85.;
    }
    
    self.calendarContentViewHeight.constant = newHeight;
    [self.view layoutIfNeeded];
}

- (IBAction)didChangeSelectModeTouch
{
    _buttonMulti.style = self.multiSelection?UIBarButtonItemStyleBordered:UIBarButtonItemStyleDone;
    
    self.multiSelection = !self.multiSelection;
    
    [self refreshSelection];
    
    [self.view layoutIfNeeded];
}

#pragma mark -- private functions
- (void) refreshSelection {
    [_datesSelected removeAllObjects];
    _currentDate = [NSDate date];
}

#pragma mark - CalendarManager delegate

// Exemple of implementation of prepareDayView method
// Used to customize the appearance of dayView
- (void)calendar:(JTCalendarManager *)calendar prepareDayView:(JTCalendarDayView *)dayView
{
    // Today
    if([_calendarManager.dateHelper date:[NSDate date] isTheSameDayThan:dayView.date]){
        dayView.circleView.hidden = NO;
        dayView.circleView.backgroundColor = [UIColor blueColor];
        dayView.dotView.backgroundColor = [UIColor whiteColor];
        dayView.textLabel.textColor = [UIColor whiteColor];
    }
    // Selected date
    else if (self.multiSelection && [self isInDatesSelected:dayView.date]) {
        dayView.circleView.hidden = NO;
        dayView.circleView.backgroundColor = [UIColor redColor];
        dayView.dotView.backgroundColor = [UIColor whiteColor];
        dayView.textLabel.textColor = [UIColor whiteColor];
    }
    else if (!self.multiSelection && _currentDate && [_calendarManager.dateHelper date:_currentDate isTheSameDayThan:dayView.date]){
        dayView.circleView.hidden = NO;
        dayView.circleView.backgroundColor = [UIColor redColor];
        dayView.dotView.backgroundColor = [UIColor whiteColor];
        dayView.textLabel.textColor = [UIColor whiteColor];
    }
    // Other month
    else if(![_calendarManager.dateHelper date:_calendarContentView.date isTheSameMonthThan:dayView.date]){
        dayView.circleView.hidden = YES;
        dayView.dotView.backgroundColor = [UIColor redColor];
        dayView.textLabel.textColor = [UIColor lightGrayColor];
    }
    // Another day of the current month
    else{
        dayView.circleView.hidden = YES;
        dayView.dotView.backgroundColor = [UIColor redColor];
        dayView.textLabel.textColor = [UIColor blackColor];
    }
    
    if([self haveEventForDay:dayView.date]){
        dayView.dotView.hidden = NO;
    }
    else{
        dayView.dotView.hidden = YES;
    }
}

- (void)calendar:(JTCalendarManager *)calendar didTouchDayView:(JTCalendarDayView *)dayView
{
    if(self.multiSelection ){
        if ([self isInDatesSelected:dayView.date]){
            [_datesSelected removeObject:dayView.date];
            
            
            [UIView transitionWithView:dayView
                              duration:.3
                               options:0
                            animations:^{
                                [_calendarManager reload];
                                dayView.circleView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.1, 0.1);
                            } completion:nil];
        }
        
        else{
            [_datesSelected addObject:dayView.date];
            
            dayView.circleView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.1, 0.1);
            [UIView transitionWithView:dayView
                              duration:.3
                               options:0
                            animations:^{
                                [_calendarManager reload];
                                dayView.circleView.transform = CGAffineTransformIdentity;
                            } completion:nil];
        }
    }
    else {
        // not multi selection
        _currentDate = dayView.date;
        
        // Animation for the circleView
        dayView.circleView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.1, 0.1);
        [UIView transitionWithView:dayView
                          duration:.3
                           options:0
                        animations:^{
                            dayView.circleView.transform = CGAffineTransformIdentity;
                            [_calendarManager reload];
                        } completion:nil];
    }
    

    
    [self updateFetchedResultsController];
    [self.tableView reloadData];
    
    
    // Load the previous or next page if touch a day from another month
    
    if(![_calendarManager.dateHelper date:_calendarContentView.date isTheSameMonthThan:dayView.date]){
        if([_calendarContentView.date compare:dayView.date] == NSOrderedAscending){
            [_calendarContentView loadNextPageWithAnimation];
        }
        else{
            [_calendarContentView loadPreviousPageWithAnimation];
        }
    }
}

#pragma mark - CalendarManager delegate - Page mangement

//// Used to limit the date for the calendar, optional
//- (BOOL)calendar:(JTCalendarManager *)calendar canDisplayPageWithDate:(NSDate *)date
//{
//    return YES;
////    return [_calendarManager.dateHelper date:date isEqualOrAfter:_minDate andEqualOrBefore:_maxDate];
//}
//
//- (void)calendarDidLoadNextPage:(JTCalendarManager *)calendar
//{
//    //    NSLog(@"Next page loaded");
//}
//
//- (void)calendarDidLoadPreviousPage:(JTCalendarManager *)calendar
//{
//    //    NSLog(@"Previous page loaded");
//    
//}


#pragma mark - Views customization

//- (UIView *)calendarBuildMenuItemView:(JTCalendarManager *)calendar
//{
//    UILabel *label = [UILabel new];
//    
//    label.textAlignment = NSTextAlignmentCenter;
//    label.font = [UIFont fontWithName:@"Avenir-Medium" size:16];
//    
//    return label;
//}
//
//- (void)calendar:(JTCalendarManager *)calendar prepareMenuItemView:(UILabel *)menuItemView date:(NSDate *)date
//{
//    static NSDateFormatter *dateFormatter;
//    if(!dateFormatter){
//        dateFormatter = [NSDateFormatter new];
//        dateFormatter.dateFormat = @"MMMM yyyy";
//        
//        dateFormatter.locale = _calendarManager.dateHelper.calendar.locale;
//        dateFormatter.timeZone = _calendarManager.dateHelper.calendar.timeZone;
//    }
//    
//    menuItemView.text = [dateFormatter stringFromDate:date];
//}
//
//- (UIView<JTCalendarWeekDay> *)calendarBuildWeekDayView:(JTCalendarManager *)calendar
//{
//    JTCalendarWeekDayView *view = [JTCalendarWeekDayView new];
//    
//    for(UILabel *label in view.dayViews){
//        label.textColor = [UIColor blackColor];
//        label.font = [UIFont fontWithName:@"Avenir-Light" size:14];
//    }
//    
//    return view;
//}
//
//- (UIView<JTCalendarDay> *)calendarBuildDayView:(JTCalendarManager *)calendar
//{
//    JTCalendarDayView *view = [JTCalendarDayView new];
//    
//    view.textLabel.font = [UIFont fontWithName:@"Avenir-Light" size:13];
//    
//    view.circleRatio = .8;
//    view.dotRatio = 1. / .9;
//    
//    return view;
//}

#pragma mark - Table view data source

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
    
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"EventCell" forIndexPath:indexPath];
    
    Event * event = [self.fetchedResultsController objectAtIndexPath:indexPath];
    [cell bindData:event];
    
    
    return nil;
    
    //    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"Region Cell"];
    //
    //    Region *region = [self.fetchedResultsController objectAtIndexPath:indexPath];
    //    cell.textLabel.text = region.name;
    //    cell.detailTextLabel.text = [NSString stringWithFormat:@"%d photographers", [[region popularity] intValue]];
    //    
    //    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    Group * group = [self.fetchedResultsController objectAtIndexPath:indexPath];
//	GroupSettingsView *groupSettingsView = [[GroupSettingsView alloc] initWith:group];
//	groupSettingsView.hidesBottomBarWhenPushed = YES;
//	[self.navigationController pushViewController:groupSettingsView animated:YES];
    Event * event = [self.fetchedResultsController objectAtIndexPath:indexPath];
    EventSettingsView * eventSettingsView = [[EventSettingsView alloc] initWithEvent:event];
    eventSettingsView.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:eventSettingsView animated:YES];
}

#pragma mark - Date selection

- (BOOL)isInDatesSelected:(NSDate *)date
{
    for(NSDate *dateSelected in _datesSelected){
        if([_calendarManager.dateHelper date:dateSelected isTheSameDayThan:date]){
            return YES;
        }
    }
    
    return NO;
}

#pragma mark - Fake data

// Used only to have a key for _eventsByDate
- (NSDateFormatter *)dateFormatter
{
    static NSDateFormatter *dateFormatter;
    if(!dateFormatter){
        dateFormatter = [NSDateFormatter new];
        dateFormatter.dateFormat = @"dd-MM-yyyy";
    }
    
    return dateFormatter;
}

- (BOOL)haveEventForDay:(NSDate *)date
{
    NSString *key = [[self dateFormatter] stringFromDate:date];
    
    if(_eventsByDate[key] && [_eventsByDate[key] count] > 0){
        return YES;
    }
    
    return NO;
    
}

- (void)createRandomEvents
{
    _eventsByDate = [NSMutableDictionary new];
    
    for(int i = 0; i < 30; ++i){
        // Generate 30 random dates between now and 60 days later
        NSDate *randomDate = [NSDate dateWithTimeInterval:(rand() % (3600 * 24 * 60)) sinceDate:[NSDate date]];
        
        // Use the date as key for eventsByDate
        NSString *key = [[self dateFormatter] stringFromDate:randomDate];
        
        if(!_eventsByDate[key]){
            _eventsByDate[key] = [NSMutableArray new];
        }
        
        [_eventsByDate[key] addObject:randomDate];
    }
}

@end

