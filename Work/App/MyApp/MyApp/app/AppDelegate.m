//
//  AppDelegate.m
//  TestTemplate
//
//  Created by AppsFoundation on 1/18/15.
//  Copyright (c) 2015 AppsFoundation. All rights reserved.
//


#import <Parse/Parse.h>
#import <ParseUI/ParseUI.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <ParseFacebookUtilsV4/PFFacebookUtils.h>

#import "AppConstant.h"
#import "common.h"

#import "AppDelegate.h"
#import "RecentView.h"
#import "GroupsView.h"
#import "PeopleView.h"
#import "SettingsView.h"
#import "CalendarViewController.h"
#import "BasicViewController.h"
#import "NavigationController.h"
#import "TestViewController.h"

#import "Appirater.h"
#import "ConfigurationManager.h"
#import "DocumentHelper.h"
#import "MSSlidingPanelController.h"
#import "Flurry.h"
#import "ThemeManager.h"

// all data model load
// 1st
#import "ThumbnailLocalDataUtil.h"
#import "PictureLocalDataUtil.h"
#import "VideoLocalDataUtil.h"
#import "UserLocalDataUtil.h"
#import "CurrentUserLocalDataUtil.h"

//2nd
#import "EventCategoryLocalDataUtil.h"
#import "AlertLocalDataUtil.h"
#import "PlaceLocalDataUtil.h"
#import "EventLocalDataUtil.h"


//3rd
#import "MessageLocalDataUtil.h"
#import "PeopleLocalDataUtil.h"
#import "GroupLocalDataUtil.h"
#import "RecentLocalDataUtil.h"

#import "Thumbnail+Util.h"

static NSInteger secondsInHour = 60;

typedef enum {
    RateAppDeclined = 0,
    RateAppConfirmed
}RateApp;

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // Remove comments to add Flurry Analytics more information here - www.flurry.com
    // NSString *flurrySessionID = [[ConfigurationManager sharedManager] flurrySessionID];
    //[Flurry startSession:@"PY8QGYRKC9HTBH8MX2SJ"];
    
    NSString * defaultPrefFile = [[NSBundle mainBundle] pathForResource:@"DefaultPreference" ofType:@"plist"];
    NSDictionary * defaultPrefDict = [NSDictionary dictionaryWithContentsOfFile:defaultPrefFile];
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults registerDefaults:defaultPrefDict];
    
    
    [Parse setApplicationId:@"IWkzJejznAWgiIdRuXrNsn6KKd1I6uOGk8JDNve0" clientKey:@"cw6PUoNh4zz3TgOedEnrEWB1CitM6xrbAiQH3Bwh"];
    //---------------------------------------------------------------------------------------------------------------------------------------------
    
    //register twitter
    /// TODO
    [PFTwitterUtils initializeWithConsumerKey:@"kS83MvJltZwmfoWVoyE1R6xko" consumerSecret:@"YXSupp9hC2m1rugTfoSyqricST9214TwYapQErBcXlP1BrSfND"];
    
    //register facebook
    [PFFacebookUtils initializeFacebookWithApplicationLaunchOptions:nil];
    //---------------------------------------------------------------------------------------------------------------------------------------------
    
    // setup push notification
    if ([application respondsToSelector:@selector(registerUserNotificationSettings:)])
    {
        UIUserNotificationType userNotificationTypes = (UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound);
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:userNotificationTypes categories:nil];
        [application registerUserNotificationSettings:settings];
        [application registerForRemoteNotifications];
    }
    
    
    // init appirater
    [self initAppiRater];
    [self initRateAppTimer];
    
    
    //configuration
    ConfigurationManager * configManager = [ConfigurationManager sharedManager];
    
    [[DocumentHelper sharedManager] createMainQueueManagedObjectContext:^(BOOL succeeded) {
        if (succeeded) {
            // nothing
            
#ifdef LOCAL_MODE
            BOOL firstStart = [userDefaults boolForKey:USER_DEFAULTS_FIRST_START];
            if (firstStart) {
                
                //User *object = [NSEntityDescription insertNewObjectForEntityForName:@"User" inManagedObjectContext:configManager.managedObjectContext];
                [[ThumbnailLocalDataUtil sharedUtil] loadData];
                
                [[PictureLocalDataUtil sharedUtil] loadData];
                
                [[VideoLocalDataUtil sharedUtil] loadData];
                
                [[UserLocalDataUtil sharedUtil] loadData];
                
                [[CurrentUserLocalDataUtil sharedUtil] loadData];
                
                [[EventCategoryLocalDataUtil sharedUtil] loadData];
                
                [[AlertLocalDataUtil sharedUtil] loadData];
                [[PlaceLocalDataUtil sharedUtil] loadData];
                [[EventLocalDataUtil sharedUtil] loadData];
                
                [[MessageLocalDataUtil sharedUtil] loadData];
                [[PeopleLocalDataUtil sharedUtil] loadData];
                [[GroupLocalDataUtil sharedUtil] loadData];
                [[RecentLocalDataUtil sharedUtil] loadData];
                
                [userDefaults setBool:NO forKey:USER_DEFAULTS_FIRST_START];

                self.initDone = YES;
                
                //NSDictionary *userInfo = self.managedObjectContext ? @{ MainDatabaseAvailableContext : self.managedObjectContext } : nil;
                [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_DATA_LOAD_READY object:self userInfo:nil];
            }
            else {
                self.initDone = YES;
                [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_DATA_LOAD_READY object:self userInfo:nil];
                
            }
            [self openMainMenu];

#endif
        }
        else {
            NSAssert(NO, @"Managed Object Context create fails");
        }
    }];
    
    //load all models
//    // 1st
//#import "ThumbnailLocalDataUtil.h"
//#import "PictureLocalDataUtil.h"
//#import "VideoLocalDataUtil.h"
//#import "UserLocalDataUtil.h"
//    
//    //2nd
//#import "AlertLocalDataUtil.h"
//#import "PlaceLocalDataUtil.h"
//#import "EventLocalDataUtil.h"
//    
//    
//    //3rd
//#import "MessageLocalDataUtil.h"
//#import "PeopleLocalDataUtil.h"
//#import "GroupLocalDataUtil.h"
//#import "RecentLocalDataUtil.h"


    //apply all theme
    [[ThemeManager sharedUtil] applyNavigationBarTheme];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    
    //---------------------------------------------------------------------------------------------------------------------------------------------
    [PFImageView class];
    //---------------------------------------------------------------------------------------------------------------------------------------------
    if (!self.tabBarController) {
        [self createTabViewController];
    }
    
    //[self openMainMenu];
    
    return YES;
}

//- (void)applicationDidBecomeActive:(UIApplication *)application {
//    [self openMainMenu];
//}

- (void)createTabViewController {
    //self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    //self.calendarView = [[TestViewController alloc] init];
    self.calendarView = [[CalendarViewController alloc] init];
    self.recentView = [[RecentView alloc] init];
    self.groupsView = [[GroupsView alloc] init];
    self.peopleView = [[PeopleView alloc] init];
    self.settingsView = [[SettingsView alloc] init];
    
    NavigationController *navController0 = [[NavigationController alloc] initWithRootViewController:self.calendarView];
    NavigationController *navController1 = [[NavigationController alloc] initWithRootViewController:self.recentView];
    NavigationController *navController2 = [[NavigationController alloc] initWithRootViewController:self.groupsView];
    NavigationController *navController3 = [[NavigationController alloc] initWithRootViewController:self.peopleView];
    NavigationController *navController4 = [[NavigationController alloc] initWithRootViewController:self.settingsView];

    
    self.tabBarController = [[UITabBarController alloc] init];
    
    //self.tabBarController.viewControllers = [NSArray arrayWithObjects:navController0, navController1, navController2, navController3, navController4, nil];
    [self.tabBarController setViewControllers:[NSArray arrayWithObjects:navController0, navController1, navController2, navController3, navController4, nil]];
    self.tabBarController.tabBar.translucent = NO;
    self.tabBarController.selectedIndex = DEFAULT_TAB;
    
    //UITabBarItem * tabBarItem = nil;
//tabBarItem = [self.tabBarController.tabBar.items objectAtIndex:0];
    UITabBarItem * tabBarItem = nil;
    tabBarItem = [self.tabBarController.tabBar.items objectAtIndex:0];
    tabBarItem.title = @"Events";
    [tabBarItem setImage:[UIImage imageNamed:@"tab_recent"]];
    
    tabBarItem = [self.tabBarController.tabBar.items objectAtIndex:1];
    tabBarItem.title = @"Recent";
    [tabBarItem setImage:[UIImage imageNamed:@"tab_recent"]];
    tabBarItem = [self.tabBarController.tabBar.items objectAtIndex:2];
    tabBarItem.title = @"Groups";
    [tabBarItem setImage:[UIImage imageNamed:@"tab_groups"]];
    tabBarItem = [self.tabBarController.tabBar.items objectAtIndex:3];
    tabBarItem.title = @"People";
    [tabBarItem setImage:[UIImage imageNamed:@"tab_people"]];
    tabBarItem = [self.tabBarController.tabBar.items objectAtIndex:4];
    tabBarItem.title = @"Settings";
    [tabBarItem setImage:[UIImage imageNamed:@"tab_settings"]];
    //1. remove all the themes to see if the calendar view can show up
    //2. default sliding window main view should be main view of calendar view
    //3.
    
    //self.window.rootViewController = self.tabBarController;
    //[self.window makeKeyAndVisible];
    
    
    
}

+ (AppDelegate *)sharedDelegate {
    return (AppDelegate *)([UIApplication sharedApplication]).delegate;
}


#pragma mark - Actions

- (void)openMainMenu {

    if (!self.tabBarController) {
        [self createTabViewController];
    }
    MSSlidingPanelController *rootController = (MSSlidingPanelController *)self.window.rootViewController;
    [rootController setCenterViewController:self.tabBarController];
    [rootController closePanel];
}


- (void)openOurMenu {
    [self openControllerWithIndentifier:@"ourMenuNavController"];
}

- (void)openReservation {
    [self openControllerWithIndentifier:@"reservationNavController"];
}

- (void)openFindUs {
    [self openControllerWithIndentifier:@"findUsNavController"];
}

- (void)openFeedback{
    [self openControllerWithIndentifier:@"feedbackNavController"];
}

#pragma mark -- private method

- (void)openControllerWithIndentifier:(NSString *)identifier {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *controller = [storyboard instantiateViewControllerWithIdentifier:identifier];
    
    MSSlidingPanelController *rootController = (MSSlidingPanelController *)self.window.rootViewController;
    
    [rootController setCenterViewController:controller];
    [rootController closePanel];
}


//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)applicationWillResignActive:(UIApplication *)application
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
    
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)applicationDidEnterBackground:(UIApplication *)application
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
    
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)applicationWillEnterForeground:(UIApplication *)application
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
    
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)applicationDidBecomeActive:(UIApplication *)application
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
    
    [FBSDKAppEvents activateApp];
    PostNotification(NOTIFICATION_APP_STARTED);
    [self locationManagerStart];
    
    //[self openOurMenu];
    //[self openMainMenu];
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)applicationWillTerminate:(UIApplication *)application
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
    
}

#pragma mark - Facebook responses

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
    return [[FBSDKApplicationDelegate sharedInstance] application:application openURL:url sourceApplication:sourceApplication annotation:annotation];
}

#pragma mark - Push notification methods

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
    PFInstallation *currentInstallation = [PFInstallation currentInstallation];
    [currentInstallation setDeviceTokenFromData:deviceToken];
    [currentInstallation saveInBackground];
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
    //NSLog(@"didFailToRegisterForRemoteNotificationsWithError %@", error);
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
    //[PFPush handlePush:userInfo];
    //---------------------------------------------------------------------------------------------------------------------------------------------
    if ([PFUser currentUser] != nil)
    {
        [self performSelector:@selector(refreshRecentView) withObject:nil afterDelay:4.0];
    }
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)refreshRecentView
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
    [self.recentView loadRecents];
}

#pragma mark - Location manager methods

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)locationManagerStart
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
    if (self.locationManager == nil)
    {
        self.locationManager = [[CLLocationManager alloc] init];
        [self.locationManager setDelegate:self];
        [self.locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
        [self.locationManager requestWhenInUseAuthorization];
    }
    [self.locationManager startUpdatingLocation];
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)locationManagerStop
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
    [self.locationManager stopUpdatingLocation];
}

#pragma mark - CLLocationManagerDelegate

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
    self.coordinate = newLocation.coordinate;
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
    
}

#pragma mark - AppiRater


- (void)initAppiRater {
    [Appirater appLaunched:YES];
    [Appirater setAppId:[[ConfigurationManager sharedManager] appId]];
    [Appirater setOpenInAppStore:YES];
}

- (void)initRateAppTimer {
    NSNumber *didShowAppRate = [[NSUserDefaults standardUserDefaults] valueForKey:@"showedAppRate"];
    if (!didShowAppRate.boolValue) {
        NSInteger showRateDelay = [[[ConfigurationManager sharedManager] rateAppDelay] integerValue] * secondsInHour;
        [NSTimer scheduledTimerWithTimeInterval:showRateDelay target:self
                                       selector:@selector(showAppRate)
                                       userInfo:nil repeats:NO];
    }
}

- (void)showAppRate {
    NSNumber *didShowAppRate = [[NSUserDefaults standardUserDefaults] valueForKey:@"showedAppRate"];
    if (![didShowAppRate boolValue]) {
        [self rateApp];
        [[NSUserDefaults standardUserDefaults] setValue:@YES forKey:@"showedAppRate"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

- (void)rateApp {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Rate the App" message:@"Do you like app?" delegate:self cancelButtonTitle:nil otherButtonTitles:@"No",@"Yes",nil];
    [alertView show];
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if ([alertView.title isEqualToString:@"Rate the App"]) {
        switch (buttonIndex) {
            case RateAppDeclined: {
                break;
            }
            case RateAppConfirmed:
                [Appirater rateApp];
                break;
            default:
                break;
        }
    }
}



@end