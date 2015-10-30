//
//  UserRemoteUtil.h
//  MyApp
//
//  Created by Linwei Ding on 9/30/15.
//  Copyright (c) 2015 AppsFoundation. All rights reserved.
//

#import "RemoteHeader.h"
#import "TypeHeader.h"
#import "BaseRemoteUtil.h"
#import <Foundation/Foundation.h>



@interface UserRemoteUtil : BaseRemoteUtil

+ (UserRemoteUtil *)sharedUtil;

//- (void) logInUser:(id)target;

// 1. download this remote object
// 2. after download, create this data model and populate
- (void) setNewObject:(BASE_REMOTE_UTIL_OBJ_TYPE)object withRemoteObject:(RemoteObject *)remoteObj inManagedObjectContext: (NSManagedObjectContext *)context;

// 1. download remote object
// 2. populate all data model attributes
- (void) setExistedObject:(BASE_REMOTE_UTIL_OBJ_TYPE)object withRemoteObject:(RemoteObject *)remoteObj inManagedObjectContext: (NSManagedObjectContext *)context;

// 1. create data model and populate
// 2. Create remote object and populate, and then save
// 3. after save, pass the objectId and time to data model
- (void) setNewRemoteObject:(RemoteObject *)remoteObj withObject:(BASE_REMOTE_UTIL_OBJ_TYPE)object;

// 1. update data model
// 2. populate remote object
// 3. after save, populate updateTime to data model
- (void) setExistedRemoteObject:(RemoteObject *)remoteObj withObject:(BASE_REMOTE_UTIL_OBJ_TYPE)object ;

- (void) setCommonObject:(BASE_REMOTE_UTIL_OBJ_TYPE)object withRemoteObject:(RemoteObject *)remoteObj inManagedObjectContext: (NSManagedObjectContext *)context;

- (void) setCommonRemoteObject:(RemoteObject *)remoteObj withObject:(BASE_REMOTE_UTIL_OBJ_TYPE)object;


- (User *) convertToUser:(RemoteUser *)user inManagedObjectContext:(NSManagedObjectContext *) context ;


- (RemoteUser *) convertToRemoteUser:(User *)user;

- (NSArray *) convertToUserArray:(NSArray *)users inManagedObjectContext:(NSManagedObjectContext *) context ;


- (void) loadUserFromParse:(NSString *)userId completionHandler:(REMOTE_OBJECT_BLOCK)block;

- (void) loadRemoteUser:(NSString *)userId completionHandler:(REMOTE_OBJECT_BLOCK)block ;

- (void) signUp:(CurrentUser *)user completionHandler:(LOCAL_BOOL_BLOCK)block ;

- (void)logInWithUsername: (NSString *)username password:(NSString *)password completionHandler:(LOCAL_BOOL_BLOCK)block;

- (void) logOut ;

//- (RemoteUser *) convertToRemoteUser;

@end
