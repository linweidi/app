//
//  UserRemoteUtil.m
//  MyApp
//
//  Created by Linwei Ding on 9/30/15.
//  Copyright (c) 2015 AppsFoundation. All rights reserved.
//
#import "AppHeader.h"
#import "Foundation/Foundation.h"

//#import "NavigationController.h"
#import "UserRemoteUtil.h"

@implementation UserRemoteUtil


+ (UserRemoteUtil *)sharedUtil {
    static dispatch_once_t predicate = 0;
    static UserRemoteUtil *sharedObject;
    
    dispatch_once(&predicate, ^{
        //initializing singleton object
        sharedObject = [[self alloc] init];
        
    });
    return sharedObject;
}

- (void) loadUserFromParse:(NSString *)userId completionHandler:(REMOTE_ARRAY_BLOCK)block {
    NSAssert(userId, @"userId is nil") ;
    
	PFQuery *query = [PFQuery queryWithClassName:PF_USER_CLASS_NAME];
	[query whereKey:PF_USER_OBJECTID equalTo:userId];
	[query findObjectsInBackgroundWithBlock:block];
}

- (void) loadRemoteUser:(NSString *)userId completionHandler:(REMOTE_ARRAY_BLOCK)block  {
    [self loadUserFromParse:userId completionHandler:block];
}

//- (void) logInUser:(id)target  {
//   	NavigationController *navigationController = [[NavigationController alloc] initWithRootViewController:[[WelcomeView alloc] init]];
//    navigationController.hidesBottomBarWhenPushed = YES;
//	[target presentViewController:navigationController animated:YES completion:nil];
//}

- (void) logOut {
    [PFUser logOut];
}

@end
