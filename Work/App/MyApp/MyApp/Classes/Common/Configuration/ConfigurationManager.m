//
//  ConfigurationManager.m
//  TestTemplate
//
//  Created by AppsFoundation on 1/19/15.
//  Copyright (c) 2015 AppsFoundation. All rights reserved.
//
#import "CurrentUser+Util.h"
#import "ConfigurationManager.h"

@interface ConfigurationManager ()

@property (nonatomic,readwrite,copy) NSString *appId;
@property (nonatomic,readwrite,copy) NSString *contactMail;
@property (nonatomic,readwrite,copy) NSNumber *rateAppDelay;
@property (nonatomic,readwrite,copy) NSString *flurrySessionID;

@property (nonatomic, strong) CurrentUser *currentUser;
@end

@implementation ConfigurationManager

#pragma mark - Singleton method

//- (void)awakeFromNib {
//    //listen to managedObjectContext when ready
//    [[NSNotificationCenter defaultCenter] addObserverForName:MainDatabaseAvailableNotification object:nil queue:nil usingBlock:^(NSNotification *note) {
//        self.managedObjectContext = note.userInfo[MainDatabaseAvailableContext];
//    }];
//}

+ (ConfigurationManager *)sharedManager {
    static dispatch_once_t predicate = 0;
    static ConfigurationManager *sharedObject;
    
    dispatch_once(&predicate, ^{
        //initializing singleton object
        sharedObject = [[self alloc] init];
        
        //load data from Configuration.plist
        [sharedObject loadData];
    });
    return sharedObject;
}

- (CurrentUser *)getCurrentUser {
    //NSAssert(self.isLoggedIn && self.currentUser, @"Your code should not get current user when logged out");
    
    
    
    
    CurrentUser * user = nil;

    
//        user = [CurrentUser fetchCurrentUserEntity:self.currentUserID inManagedObjectContext:self.managedObjectContext ];
//        NSAssert(!user, @"Your code should not get nil user when call get Current user");

    user = self.currentUser;
    
    return user;
}

- (void)setCurrentUser: (CurrentUser *) user {
    _currentUser = user;
}

- (void)clearCurrentUserContext {
    _currentUser = nil;
    self.isLoggedIn = NO;
}

#pragma mark - Private methods

- (void)loadData {
    NSString* path = [[NSBundle mainBundle] pathForResource:@"Configuration" ofType:@"plist"];
    NSDictionary *configDict = [[NSDictionary alloc] initWithContentsOfFile:path];
    
    self.appId = configDict[@"AppId"];
    self.contactMail = configDict[@"ContactMail"];
    self.rateAppDelay = configDict[@"RateAppDelayInMinutes"];
    self.flurrySessionID = configDict[@"FlurrySessionID"];
}


@end