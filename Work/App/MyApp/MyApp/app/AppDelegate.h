//
//  AppDelegate.h
//  TestTemplate
//
//  Created by AppsFoundation on 1/18/15.
//  Copyright (c) 2015 AppsFoundation. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "RecentView.h"
#import "GroupsView.h"
#import "PeopleView.h"
#import "SettingsView.h"
#import "CalendarViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate, CLLocationManagerDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UITabBarController *tabBarController;

@property (strong, nonatomic) CalendarViewController *calendarView;
@property (strong, nonatomic) RecentView *recentView;
@property (strong, nonatomic) GroupsView *groupsView;
@property (strong, nonatomic) PeopleView *peopleView;
@property (strong, nonatomic) SettingsView *settingsView;

@property (strong, nonatomic) CLLocationManager *locationManager;
@property (nonatomic) CLLocationCoordinate2D coordinate;


+ (AppDelegate *)sharedDelegate;

//Actions
- (void)openOurMenu;
- (void)openReservation;
- (void)openFindUs;
- (void)openFeedback;
- (void)openMainMenu;
@end