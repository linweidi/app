//
//  GroupRemoteUtil.h
//  MyApp
//
//  Created by Linwei Ding on 9/30/15.
//  Copyright (c) 2015 AppsFoundation. All rights reserved.
//
#import "AppHeader.h"
#import <Foundation/Foundation.h>
#import "UserBaseRemoteUtil.h"
#import <Parse/Parse.h>

@class Group;
//-------------------------------------------------------------------------------------------------------------------------------------------------
void			RemoveGroupMembers		(PFUser *user1, PFUser *user2);

//-------------------------------------------------------------------------------------------------------------------------------------------------
void			RemoveGroupMember		(PFObject *group, PFUser *user);
void			RemoveGroupItem			(PFObject *group);

@interface GroupRemoteUtil : UserBaseRemoteUtil
+ (GroupRemoteUtil *)sharedUtil;

#pragma mark -- private functions
- (void) setCommonObject:(BASE_REMOTE_UTIL_OBJ_TYPE)object withRemoteObject:(RemoteObject *)remoteObj inManagedObjectContext: (NSManagedObjectContext *)context;

- (void) setCommonRemoteObject:(RemoteObject *)remoteObj withAlert:(BASE_REMOTE_UTIL_OBJ_TYPE)object;

#pragma mark -- external functions
- (void) loadRemoteGroups:(Group *)latestGroup completionHandler:(REMOTE_ARRAY_BLOCK)block ;

- (void) loadRemoteUsersByGroup:(Group *)group  completionHandler:(REMOTE_ARRAY_BLOCK)block;

- (void) createRemoteGroup:(NSString *)name members:(NSArray *)members completionHandler:(REMOTE_OBJECT_BLOCK)block ;

- (void) removeGroupMember:(Group *)group user:(User *)user completionHandler:(REMOTE_BOOL_BLOCK)block;

- (void) removeGroupItem:(Group *) group completionHandler:(REMOTE_BOOL_BLOCK)block;
@end
