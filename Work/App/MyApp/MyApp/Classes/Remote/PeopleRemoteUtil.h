//
//  PeopleRemoteUtil.h
//  MyApp
//
//  Created by Linwei Ding on 10/1/15.
//  Copyright (c) 2015 AppsFoundation. All rights reserved.
//
#import <Parse/Parse.h>
#import "AppHeader.h"
#import "UserBaseRemoteUtil.h"
#import "People+Util.h"
#import <Foundation/Foundation.h>

//void			PeopleSave				(PFUser *user1, PFUser *user2);
//void			PeopleDelete			(PFUser *user1, PFUser *user2);



@interface PeopleRemoteUtil : UserBaseRemoteUtil

+ (PeopleRemoteUtil *)sharedUtil;

#pragma mark -- private functions
- (void) setCommonObject:(BASE_REMOTE_UTIL_OBJ_TYPE)object withRemoteObject:(RemoteObject *)remoteObj inManagedObjectContext: (NSManagedObjectContext *)context;

- (void) setCommonRemoteObject:(RemoteObject *)remoteObj withAlert:(BASE_REMOTE_UTIL_OBJ_TYPE)object;

//- (void)setExistedObject:(SystemEntity *)object withRemoteObject:(RemoteObject *)remoteObj inManagedObjectContext:(NSManagedObjectContext *)context ;
//
//- (void)setNewObject:(SystemEntity *)object withRemoteObject:(RemoteObject *)remoteObj inManagedObjectContext:(NSManagedObjectContext *)context ;
//
////- (void)setExistedRemoteObject:(RemoteObject *)remoteObj withObject:(SystemEntity *)object;
//
//- (void)setNewRemoteObject:(RemoteObject *)remoteObj withObject:(SystemEntity *)object;

#pragma mark -- external functions


- (void) loadRemotePeoples:(People *)latestPeople completionHandler:(REMOTE_ARRAY_BLOCK)block;

- (void) createRemotePeople:(NSString *)name user:(User *)user2 completionHandler:(REMOTE_OBJECT_BLOCK)block;

//- (void) createRemotePeople:(NSString *)name user:(User *)user2 completionHandler:(REMOTE_OBJECT_BLOCK)block ;

- (void) deleteRemotePeople:(User *)user2  completionHandler:(REMOTE_BOOL_BLOCK)block;

@end
