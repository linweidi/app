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
#import "User+Util.h"
#import "CurrentUser+Util.h"
#import "UserRemoteUtil.h"
#import "Group+Util.h"

////-------------------------------------------------------------------------------------------------------------------------------------------------
//void RemoveGroupMembers(PFUser *user1, PFUser *user2)
////-------------------------------------------------------------------------------------------------------------------------------------------------
//{
//	PFQuery *query = [PFQuery queryWithClassName:PF_GROUP_CLASS_NAME];
//	[query whereKey:PF_GROUP_USER equalTo:user1];
//	[query whereKey:PF_GROUP_MEMBERS equalTo:user2.objectId];
//	[query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error)
//     {
//         if (error == nil)
//         {
//             for (PFObject *group in objects)
//             {
//                 RemoveGroupMember(group, user2);
//             }
//         }
//         else NSLog(@"RemoveGroupMembers query error.");
//     }];
//}
//
////-------------------------------------------------------------------------------------------------------------------------------------------------
//void RemoveGroupMember(PFObject *group, PFUser *user)
////-------------------------------------------------------------------------------------------------------------------------------------------------
//{
//    
//	if ([group[PF_GROUP_MEMBERS] containsObject:user.objectId])
//	{
//		[group[PF_GROUP_MEMBERS] removeObject:user.objectId];
//		[group saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error)
//         {
//             if (error != nil) NSLog(@"RemoveGroupMember save error.");
//         }];
//	}
//}
//
////-------------------------------------------------------------------------------------------------------------------------------------------------
//void RemoveGroupItem(PFObject *group)
////-------------------------------------------------------------------------------------------------------------------------------------------------
//{
//	[group deleteInBackgroundWithBlock:^(BOOL succeeded, NSError *error)
//     {
//         if (error != nil) NSLog(@"RemoveGroupItem delete error.");
//     }];
//}

@implementation GroupRemoteUtil

+ (GroupRemoteUtil *)sharedUtil {
    static dispatch_once_t predicate = 0;
    static GroupRemoteUtil *sharedObject;
    
    dispatch_once(&predicate, ^{
        //initializing singleton object
        sharedObject = [[self alloc] init];
        
        sharedObject.className = PF_GROUP_CLASS_NAME;
    });
    return sharedObject;
}


- (void) setCommonObject:(BASE_REMOTE_UTIL_OBJ_TYPE)object withRemoteObject:(RemoteObject *)remoteObj inManagedObjectContext: (NSManagedObjectContext *)context{
    NSAssert([object isKindOfClass:[Group class]], @"Type casting is wrong");
    Group * group = (Group *)object;
    
	//group.user = [[ConfigurationManager sharedManager] getCurrentUser];
	group.name = remoteObj[PF_GROUP_NAME] ;
    group.members = remoteObj[PF_GROUP_MEMBERS];
    
    
}

- (void) setCommonRemoteObject:(RemoteObject *)remoteObj withAlert:(BASE_REMOTE_UTIL_OBJ_TYPE)object {
    NSAssert([object isKindOfClass:[Group class]], @"Type casting is wrong");
    Group * group = (Group *)object;
	remoteObj[PF_GROUP_USER] = [PFUser currentUser];
	remoteObj[PF_GROUP_NAME] = group.name;
	remoteObj[PF_GROUP_MEMBERS] = group.members;
}





- (void) loadRemoteUsersByGroup:(Group *)group  completionHandler:(REMOTE_ARRAY_BLOCK)block{
    PFQuery *query = [PFQuery queryWithClassName:PF_USER_CLASS_NAME];
	[query whereKey:PF_USER_OBJECTID containedIn:group.members];
	[query orderByAscending:PF_USER_FULLNAME];
	[query setLimit:GROUPVIEW_USER_ITEM_NUM];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        NSArray * userObjArray = [[UserRemoteUtil sharedUtil] convertToUserArray:objects];
        //        for (PFUser * object in objects) {
        //
        //        }
        block(userObjArray, error);
    }];
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
    
    [query setLimit:GROUPVIEW_ITEM_NUM];
    
    if (latestGroup) {
        //found any recent itme
        [query whereKey:PF_GROUP_UPDATE_TIME greaterThan:latestGroup.updateTime];
        [self downloadObjectsWithQuery:query completionHandler:^(NSArray *remoteObjs, NSArray *objects, NSError *error) {
            block(objects, error);
        }];
    }
    else {
        [self downloadCreateObjectsWithQuery:query completionHandler:^(NSArray *remoteObjs, NSArray *objects, NSError *error) {
            block(objects, error);
        }];
    }
    
    
    
}

- (void) createRemoteGroup:(NSString *)name members:(NSArray *)members completionHandler:(REMOTE_OBJECT_BLOCK)block {
    [self createGroupPF:name members:members completionHandler:block];
}

- (void) createGroupPF:(NSString *)name members:(NSArray *)members completionHandler:(REMOTE_OBJECT_BLOCK)block {
//    PFObject *object = [PFObject objectWithClassName:PF_GROUP_CLASS_NAME];
//	object[PF_GROUP_USER] = [PFUser currentUser];
//	object[PF_GROUP_NAME] = name;
//	object[PF_GROUP_MEMBERS] = members;
//	[object saveInBackgroundWithBlock:block];
    
    Group * group  = [Group createEntity:nil];
    group.userVolatile = [[ConfigurationManager sharedManager] getCurrentUser];
    group.name = name;
    group.members = members;
    [self uploadCreateRemoteObject:group  completionHandler:block];
    
}



//-------------------------------------------------------------------------------------------------------------------------------------------------
// delete the user in the group
- (void) removeGroupMember:(Group *)group user:(User *)user completionHandler:(REMOTE_BOOL_BLOCK)block {
    //PFObject * groupPF = [PFObject objectWithoutDataWithClassName:PF_GROUP_CLASS_NAME objectId:group.globalID];
    //[groupPF getO]

    
    [self downloadUpdateObject:group includeKeys:nil completionHandler:^(PFObject *remoteObj, id object, NSError *error) {
        if ([remoteObj[PF_GROUP_MEMBERS] containsObject:user.globalID])
        {
            if ([remoteObj[PF_GROUP_MEMBERS] count] == 1) {
                // only the user is left, delete the remote object
                [self uploadRemoveRemoteObject:group completionHandler:block];
                //[object deleteInBackgroundWithBlock:block];
            }
            else {
                // other users are left, just remove the member of the user
                [remoteObj[PF_GROUP_MEMBERS] removeObject:user.globalID];
                [self uploadUpdateRemoteObject:remoteObj modifyObject:group completionHandler:^(id object, NSError *error) {
                    block(!error, error);
                }];
            }
        }
    }];
}


// delete the user in the group
- (void) removeGroupMemberAll:(User *)createdUser user:(User *)user completionHandler:(REMOTE_BOOL_BLOCK)block {
    //PFObject * groupPF = [PFObject objectWithoutDataWithClassName:PF_GROUP_CLASS_NAME objectId:group.globalID];
    //[groupPF getO]
    
	PFQuery *query = [PFQuery queryWithClassName:PF_GROUP_CLASS_NAME];
	[query whereKey:PF_GROUP_USER equalTo:[PFUser currentUser]];
	[query whereKey:PF_GROUP_MEMBERS equalTo:user.globalID];
    
    [self downloadObjectsWithQuery:query completionHandler:^(NSArray *remoteObjs, NSArray *objects, NSError *error) {
        if (!error) {
            int count = 0;
            Group * group = objects[count];
            
            for (PFObject *groupRMT in remoteObjs)
            {
                
                if ([groupRMT[PF_GROUP_MEMBERS] containsObject:user.globalID])
                {
                    if ([groupRMT[PF_GROUP_MEMBERS] count] == 1) {
                        // only the user is left, delete the remote object
                        [self uploadRemoveRemoteObject:group completionHandler:block];
                        //[object deleteInBackgroundWithBlock:block];
                    }
                    else {
                        // other users are left, just remove the member of the user
                        [groupRMT removeObject:user.globalID forKey:PF_GROUP_MEMBERS];
                        [self uploadUpdateRemoteObject:groupRMT modifyObject:group completionHandler:^(id object, NSError *error) {
                            NSMutableArray * memberIDs = [[NSMutableArray alloc] init];
                            memberIDs = [group.members mutableCopy];
                            [memberIDs removeObject:user.globalID];
                            group.members = memberIDs;
                            
                            block(!error, error);
                        }];
                    }
                }
                
                count++;
            }
        }
        else {
            [ProgressHUD showError:@"Network Error."];
        }
    }];
}

// delete the group
- (void) removeGroupItem:(Group *) group completionHandler:(REMOTE_BOOL_BLOCK)block {
    [self uploadRemoveRemoteObject:group completionHandler:block];
}

@end
