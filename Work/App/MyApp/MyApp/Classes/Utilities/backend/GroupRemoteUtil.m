//
//  GroupRemoteUtil.m
//  MyApp
//
//  Created by Linwei Ding on 9/30/15.
//  Copyright (c) 2015 AppsFoundation. All rights reserved.
//

#import "AppHeader.h"
#import "GroupRemoteUtil.h"

#import <Parse/Parse.h>

#import "AppConstant.h"

#import "Group+Util.h"

//-------------------------------------------------------------------------------------------------------------------------------------------------
void RemoveGroupMembers(PFUser *user1, PFUser *user2)
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	PFQuery *query = [PFQuery queryWithClassName:PF_GROUP_CLASS_NAME];
	[query whereKey:PF_GROUP_USER equalTo:user1];
	[query whereKey:PF_GROUP_MEMBERS equalTo:user2.objectId];
	[query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error)
     {
         if (error == nil)
         {
             for (PFObject *group in objects)
             {
                 RemoveGroupMember(group, user2);
             }
         }
         else NSLog(@"RemoveGroupMembers query error.");
     }];
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
void RemoveGroupMember(PFObject *group, PFUser *user)
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	if ([group[PF_GROUP_MEMBERS] containsObject:user.objectId])
	{
		[group[PF_GROUP_MEMBERS] removeObject:user.objectId];
		[group saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error)
         {
             if (error != nil) NSLog(@"RemoveGroupMember save error.");
         }];
	}
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
void RemoveGroupItem(PFObject *group)
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	[group deleteInBackgroundWithBlock:^(BOOL succeeded, NSError *error)
     {
         if (error != nil) NSLog(@"RemoveGroupItem delete error.");
     }];
}

@implementation GroupRemoteUtil

+ (GroupRemoteUtil *)sharedUtil {
    static dispatch_once_t predicate = 0;
    static GroupRemoteUtil *sharedObject;
    
    dispatch_once(&predicate, ^{
        //initializing singleton object
        sharedObject = [[self alloc] init];
        
    });
    return sharedObject;
}



- (void) loadRemoteUsersByGroup:(Group *)group  completionHandler:(REMOTE_ARRAY_BLOCK)block{
    PFQuery *query = [PFQuery queryWithClassName:PF_USER_CLASS_NAME];
	[query whereKey:PF_USER_OBJECTID containedIn:group.members];
	[query orderByAscending:PF_USER_FULLNAME];
	[query setLimit:GROUPVIEW_USER_ITEM_NUM];
	[query findObjectsInBackgroundWithBlock:block];
}

- (void) loadRemoteGroups:(Group *)latestGroup completionHandler:(REMOTE_ARRAY_BLOCK)block {
    [self loadGroupsFromParse:latestGroup completionHandler:block];
}

- (void) loadGroupsFromParse:(Group *)latestGroup completionHandler:(REMOTE_ARRAY_BLOCK)block {
    
    
	PFUser *user = [PFUser currentUser];
    
	PFQuery *query = [PFQuery queryWithClassName:PF_GROUP_CLASS_NAME];
	[query whereKey:PF_GROUP_MEMBERS equalTo:user.objectId];
    
    [query includeKey:PF_GROUP_USER];
    
    [query orderByDescending:PF_GROUP_NAME];
    
    if (latestGroup) {
        //found any recent itme
        [query whereKey:PF_GROUP_UPDATE_TIME greaterThan:latestGroup.updateTime];
    }
    
	[query findObjectsInBackgroundWithBlock:block];
    
}

- (void) createRemoteGroup:(NSString *)name members:(NSArray *)members completionHandler:(REMOTE_BOOL_BLOCK)block {
    [self createPFGroup:name members:members completionHandler:block];
}

- (void) createPFGroup:(NSString *)name members:(NSArray *)members completionHandler:(REMOTE_BOOL_BLOCK)block {
    PFObject *object = [PFObject objectWithClassName:PF_GROUP_CLASS_NAME];
	object[PF_GROUP_USER] = [PFUser currentUser];
	object[PF_GROUP_NAME] = name;
	object[PF_GROUP_MEMBERS] = members;
	[object saveInBackgroundWithBlock:block];
}


//-------------------------------------------------------------------------------------------------------------------------------------------------
// delete the user in the group
- (void) removeGroupMember:(Group *)group user:(User *)user {
    //PFObject * groupPF = [PFObject objectWithoutDataWithClassName:PF_GROUP_CLASS_NAME objectId:group.globalID];
    //[groupPF getO]
    
    PFQuery *query = [PFQuery queryWithClassName:PF_GROUP_CLASS_NAME];
    [query getObjectInBackgroundWithId:group.globalID block:^(PFObject *object, NSError *error) {
        if ([object[PF_GROUP_MEMBERS] containsObject:user.globalID])
        {
            if ([object[PF_GROUP_MEMBERS] count] == 1) {
                // only the user is left, delete the remote object
                [object deleteInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                    if (error != nil) NSLog(@"RemoveGroupItem delete error.");
                }];
            }
            else {
                // other users are left, just remove the member of the user
                [object[PF_GROUP_MEMBERS] removeObject:user.globalID];
                [object saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error)
                 {
                     if (error != nil) NSLog(@"RemoveGroupMember save error.");
                 }];
            }
        }
    }];
}

// delete the group
- (void) removeGroupItem:(Group *) group {
    PFQuery *query = [PFQuery queryWithClassName:PF_GROUP_CLASS_NAME];
    [query getObjectInBackgroundWithId:group.globalID block:^(PFObject *object, NSError *error) {
        [object deleteInBackgroundWithBlock:^(BOOL succeeded, NSError *error)
         {
             if (error != nil) NSLog(@"RemoveGroupItem delete error.");
         }];
    }];
}

@end
