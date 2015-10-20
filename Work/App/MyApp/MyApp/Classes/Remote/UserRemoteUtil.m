//
//  UserRemoteUtil.m
//  MyApp
//
//  Created by Linwei Ding on 9/30/15.
//  Copyright (c) 2015 AppsFoundation. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>
//#import "NavigationController.h"
#import "RemoteHeader.h"

#import "AppConstant.h"
#import "CurrentUser+Util.h"
#import "User+Util.h"
#import "ConfigurationManager.h"
#import "push.h"
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

- (BOOL) existUsername: (NSString *) userID {
    BOOL ret = NO;
    
    NSAssert([userID length]!=0 , @"not valid userId");
    
    return ret;
}

- (void) signUp:(CurrentUser *)user completionHandler:(LOCAL_BOOL_BLOCK)block {

    PFUser * userRT = [UserRemoteUtil convertFromCurrentUser:user];
    ConfigurationManager * config = [ConfigurationManager sharedManager];
    
    // here, it will check if the username and email has already existed
    [userRT signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            // update the isLogggedIn
            
            
            // remote create the local current user
            CurrentUser * currentUser = [CurrentUser createCurrentUserEntity:config.managedObjectContext];
            // update current user and add inot user manager
            [currentUser setWithRemoteUser:userRT inManagedObjectContext:config.managedObjectContext];
            

            
            if (currentUser) {
                // populate the current user to configuration manager
                config.currentUserID = currentUser.globalID;
                [config setCurrentUser:currentUser];
                
                block(succeeded, error);
                
                config.isLoggedIn = YES;
            }

        }
    }];
}

- (void)logInWithUsername: (NSString *)username password:(NSString *)password completionHandler:(LOCAL_BOOL_BLOCK)block {
    
    ConfigurationManager * config = [ConfigurationManager sharedManager];
    
    [PFUser logInWithUsernameInBackground:username password:password block:^(PFUser *user, NSError *error)
     {
         if (user != nil)
         {

             
             CurrentUser * currentUser = nil;
             
             // remote create the local current user
             currentUser  = [CurrentUser fetchCurrentUserEntityWithUsername:username inManagedObjectContext:config.managedObjectContext ];
             if (!currentUser) {
                 currentUser = [CurrentUser createCurrentUserEntity:config.managedObjectContext];
                 // update current user and add inot user manager
                 [currentUser setWithRemoteUser:user inManagedObjectContext:config.managedObjectContext];
             }
             
             
             if (currentUser) {
                 // populate the current user to configuration manager
                 config.currentUserID = currentUser.globalID;
                 [config setCurrentUser:currentUser];
                 
                 ParsePushUserAssign();
                 [ProgressHUD showSuccess:[NSString stringWithFormat:@"Welcome back %@!", user[PF_USER_FULLNAME]]];
                 
                 block(YES, error);
                 
                 // update the isLogggedIn
                 config.isLoggedIn = YES;
             }
         }
         else [ProgressHUD showError:error.userInfo[@"error"]];
     }];
}

- (void) logOut {
    ConfigurationManager * config = [ConfigurationManager sharedManager];
    [config clearCurrentUserContext];
    [PFUser logOut];
}

//- (void) populateCurrentUserEntity:(CurrentUser *)currentUser fromUser:(CurrentUser *)user {
//
//    currentUser.username = user.username;
//    currentUser.password = user.password;
//    currentUser.email = user.email;
//    
//    currentUser.emailCopy = user.email;
//    currentUser.fullname = user.username;
//    currentUser.fullnameLower = [user.username lowercaseString];
//}

+ (RemoteUser *) convertFromCurrentUser: (CurrentUser *)currentUser {
    RemoteUser * user = [User convertToRemoteUser:currentUser];
    // more specific for CurrentUser of Remote
    return user;
}
//- (RemoteUser *) convertToRemoteUser {
//    return [self convertToPFUser];
//}
//
//- (PFUser *) convertToPFUser {
//    RemoteUser * user = [self convertToPFUser];
//    return user;
//}
@end
