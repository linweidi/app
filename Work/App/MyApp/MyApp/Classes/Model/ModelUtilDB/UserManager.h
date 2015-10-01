//
//  UserManager.h
//  MyApp
//
//  Created by Linwei Ding on 9/30/15.
//  Copyright (c) 2015 AppsFoundation. All rights reserved.
//

#import <Foundation/Foundation.h>

@class User;

@interface UserContext : NSObject

@property (strong, nonatomic) User * user;

@property (strong, nonatomic) NSString * thumbName;

@property (strong, nonatomic) Thumbnail * thumb;

+ (UserContext *)userContext:(User *)user thumbName:(NSString *)thumbName thumb:(Thumbnail *)thumb;

@end
 
#warning load all the users and populate from core data when system starts up

@interface UserManager : NSObject

+ (UserManager *)sharedUtil;

- (BOOL) addUser:(User *)user ;

- (BOOL) removeUser: (NSString *) userID;

- (BOOL) exists: (NSString *) userID;

- (User *) getUser: (NSString *) userID;

- (User *) extractUser:(NSString *)userID;

- (UserContext *) getContext: (NSString *) userID ;

- (Thumbnail *) getThumbnail: (NSString *) userID ;
@end
