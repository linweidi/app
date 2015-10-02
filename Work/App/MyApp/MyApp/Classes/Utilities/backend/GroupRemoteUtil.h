//
//  GroupRemoteUtil.h
//  MyApp
//
//  Created by Linwei Ding on 9/30/15.
//  Copyright (c) 2015 AppsFoundation. All rights reserved.
//
#import "AppHeader.h"
#import <Foundation/Foundation.h>

#import <Parse/Parse.h>

//-------------------------------------------------------------------------------------------------------------------------------------------------
void			RemoveGroupMembers		(PFUser *user1, PFUser *user2);

//-------------------------------------------------------------------------------------------------------------------------------------------------
void			RemoveGroupMember		(PFObject *group, PFUser *user);
void			RemoveGroupItem			(PFObject *group);

@interface GroupRemoteUtil : NSObject
+ (GroupRemoteUtil *)sharedUtil;


- (void) loadRemoteGroups:(Group *)latestGroup completionHandler:(REMOTE_ARRAY_BLOCK)block ;

- (void) loadRemoteUsersByGroup:(Group *)group  completionHandler:(REMOTE_ARRAY_BLOCK)block;

- (void) createRemoteGroup:(NSString *)name members:(NSArray *)members completionHandler:(REMOTE_BOOL_BLOCK)block ;

- (void) removeGroupMember:(Group *)group user:(User *)user ;

- (void) removeGroupItem:(Group *) group;
@end
