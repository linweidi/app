//
// Copyright (c) 2015 Related Code - http://relatedcode.com
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import <Parse/Parse.h>
#import "AppHeader.h"
#import "PFUser+Util.h"
#import "ProgressHUD.h"
#import "CurrentUser+Util.h"
#import "DataModelHeader.h"

#import "User+Util.h"
#import "RecentView.h"
#import "ConfigurationManager.h"
#import "RecentRemoteUtil.h"

////-------------------------------------------------------------------------------------------------------------------------------------------------
//NSString* StartPrivateChat(User *user1, User *user2, NSManagedObjectContext * context)
////-------------------------------------------------------------------------------------------------------------------------------------------------
//{
//
//	NSString *id1 = user1.globalID;
//	NSString *id2 = user2.globalID;
//	//---------------------------------------------------------------------------------------------------------------------------------------------
//	NSString *groupId = ([id1 compare:id2] < 0) ? [NSString stringWithFormat:@"%@%@", id1, id2] : [NSString stringWithFormat:@"%@%@", id2, id1];
//	//---------------------------------------------------------------------------------------------------------------------------------------------
//	NSArray *members = @[user1.globalID, user2.globalID];
//	//---------------------------------------------------------------------------------------------------------------------------------------------
//	CreateRecentItem(user1, groupId, members, user2.fullname, context);
//	CreateRecentItem(user2, groupId, members, user1.fullname, context);
//	//---------------------------------------------------------------------------------------------------------------------------------------------
//	return groupId;
//}
//
////-------------------------------------------------------------------------------------------------------------------------------------------------
//NSString* StartMultipleChat(NSMutableArray *users, NSManagedObjectContext * context)
////-------------------------------------------------------------------------------------------------------------------------------------------------
//{
//	NSString *groupId = @"";
//	NSString *description = @"";
//	//---------------------------------------------------------------------------------------------------------------------------------------------
//	[users addObject:[[ConfigurationManager sharedManager] getCurrentUser]];
//	//---------------------------------------------------------------------------------------------------------------------------------------------
//	NSMutableArray *userIds = [[NSMutableArray alloc] init];
//	//---------------------------------------------------------------------------------------------------------------------------------------------
//	for (User *user in users)
//	{
//		[userIds addObject: user.globalID];
//	}
//	//---------------------------------------------------------------------------------------------------------------------------------------------
//	NSArray *sorted = [userIds sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
//	//---------------------------------------------------------------------------------------------------------------------------------------------
//	
//    // Create group id
//    for (NSString *userId in sorted)
//	{
//		groupId = [groupId stringByAppendingString:userId];
//	}
//	//---------------------------------------------------------------------------------------------------------------------------------------------
//	for (User *user in users)
//	{
//		if ([description length] != 0) description = [description stringByAppendingString:@" & "];
//		description = [description stringByAppendingString:user.fullname];
//	}
//	//---------------------------------------------------------------------------------------------------------------------------------------------
//	for (User *user in users)
//	{
//		CreateRecentItem(user, groupId, userIds, description, context);
//	}
//	//---------------------------------------------------------------------------------------------------------------------------------------------
//	return groupId;
//}
//
////-------------------------------------------------------------------------------------------------------------------------------------------------
//void CreateRecentItem(User *user, NSString *groupId, NSArray *members, NSString *description, NSManagedObjectContext * context)
////-------------------------------------------------------------------------------------------------------------------------------------------------
//{
//    //create the remote query
//    // HERE, checking the existence of recent on server is required. because the other users may have already deleted the item.
//	PFQuery *query = [PFQuery queryWithClassName:PF_RECENT_CLASS_NAME];
//	[query whereKey:PF_RECENT_USER equalTo:[user convertToPFUser]];
//	[query whereKey:PF_RECENT_GROUPID equalTo:groupId];
//	[query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error)
//	{
//		if (error == nil)
//		{
//			if ([objects count] == 0)
//			{
//                // create a new chat
//				PFObject *recent = [PFObject objectWithClassName:PF_RECENT_CLASS_NAME];
//				recent[PF_RECENT_USER] = [user convertToPFUser];
//				recent[PF_RECENT_GROUPID] = groupId;
//				recent[PF_RECENT_MEMBERS] = members;
//				recent[PF_RECENT_DESCRIPTION] = description;
//				recent[PF_RECENT_LASTUSER] = [PFUser currentUser];
//				recent[PF_RECENT_LASTMESSAGE] = @"";
//				recent[PF_RECENT_COUNTER] = @0;
//				recent[PF_RECENT_UPDATEDACTION] = [NSDate date];
//				[recent saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error)
//				{
//					if (error != nil) {
//                        [ProgressHUD showError:@"CreateRecentItem save error."];
//                    }
//                    else if (succeeded){
//                        if ([user isEqual: [CurrentUser getCurrentUser]]) {
//                            Recent * obj = [Recent recentEntityWithPFObject:recent inManagedObjectContext:context];
//                            
//                            if (!obj) {
//                                NSLog(@"CreateRecentItem does not insert into core data.");
//                                [ProgressHUD showError:@"CreateRecentItem does not insert into core data."];
//                                ///TODO delete the saved data on server or redo the local save
//                            
//                            }
//                        }
//                    }
//				}];
//                
//                
//                
// 
//			}
//		}
//		else {
//            NSLog(@"CreateRecentItem query error.");
//            [ProgressHUD showError:@"Network error."];
//        }
//        
//	}];
//}
//
////-------------------------------------------------------------------------------------------------------------------------------------------------
//// Update all users' recent and counter
//void UpdateRecentAndCounter(NSString *groupId, NSInteger amount, NSString *lastMessage, NSManagedObjectContext * context)
////-------------------------------------------------------------------------------------------------------------------------------------------------
//{
//	PFQuery *query = [PFQuery queryWithClassName:PF_RECENT_CLASS_NAME];
//	[query whereKey:PF_RECENT_GROUPID equalTo:groupId];
//	[query includeKey:PF_RECENT_USER];
//    //[query setLimit:1000];
//	[query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error)
//	{
//		if (error == nil)
//		{
//			for (PFObject *recent in objects)
//			{
//				if ([recent[PF_RECENT_USER] isEqualTo:[PFUser currentUser]] == NO) {
//                    // update the counter of others only
//                    [recent incrementKey:PF_RECENT_COUNTER byAmount:[NSNumber numberWithInteger:amount]];
//                }
//					
//				//---------------------------------------------------------------------------------------------------------------------------------
//				recent[PF_RECENT_LASTUSER] = [PFUser currentUser];
//				recent[PF_RECENT_LASTMESSAGE] = lastMessage;
//				recent[PF_RECENT_UPDATEDACTION] = [NSDate date];
//				[recent saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error)
//				{
//					if (error != nil) NSLog(@"UpdateRecentCounter save error.");
//                    else if(succeeded){
//                        /// TODO only update
//                        Recent * obj = [Recent recentEntityWithPFObject:recent inManagedObjectContext:context];
//                        
//                        if (!obj) {
//                            NSLog(@"CreateRecentItem does not insert into core data.");
//                        }
//                    }
//
//				}];
//			}
//            ///TODO if not existed, we need create one recent item for that user
//            //use sorted user and update the user group each update, eventually the rest of user group is the ones to be created
//		}
//		else NSLog(@"UpdateRecentCounter query error.");
//	}];
//}
//
////-------------------------------------------------------------------------------------------------------------------------------------------------
//// clear only my recent counter
//void ClearRecentCounter(NSString *groupId, NSManagedObjectContext * context)
////-------------------------------------------------------------------------------------------------------------------------------------------------
//{
//	PFQuery *query = [PFQuery queryWithClassName:PF_RECENT_CLASS_NAME];
//	[query whereKey:PF_RECENT_GROUPID equalTo:groupId];
//	[query whereKey:PF_RECENT_USER equalTo:[PFUser currentUser]];
//	[query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error)
//	{
//		if (error == nil)
//		{
//			for (PFObject *recent in objects)
//			{
//				recent[PF_RECENT_COUNTER] = @0;
//				[recent saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error)
//				{
//					if (error != nil) NSLog(@"ClearRecentCounter save error.");
//                    else if(succeeded){
//                        /// TODO only update
//                        Recent * obj = [Recent recentEntityWithPFObject:recent inManagedObjectContext:context];
//                        
//                        if (!obj) {
//                            NSLog(@"CreateRecentItem does not insert into core data.");
//                        }
//                    }
//				}];
//			}
//		}
//		else NSLog(@"ClearRecentCounter query error.");
//	}];
//}
//
////-------------------------------------------------------------------------------------------------------------------------------------------------
//void DeleteRecentItems(User *user1, User *user2, NSManagedObjectContext * context)
////-------------------------------------------------------------------------------------------------------------------------------------------------
//{
//	PFQuery *query = [PFQuery queryWithClassName:PF_RECENT_CLASS_NAME];
//	[query whereKey:PF_RECENT_USER equalTo: [user1 convertToPFUser] ];
//	[query whereKey:PF_RECENT_MEMBERS equalTo:user2.globalID];
//	[query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error)
//	{
//		if (error == nil)
//		{
//			for (PFObject *recent in objects)
//			{
//				[recent deleteInBackgroundWithBlock:^(BOOL succeeded, NSError *error)
//				{
//					if (error != nil) NSLog(@"DeleteMessageItem delete error.");
//                    else if(succeeded){
//                        /// TODO only update
//                        BOOL deleted = [Recent deleteRecentEntityWithPFObject:recent inManagedObjectContext:context];
//                        
//                        if (!deleted) {
//                            NSLog(@"CreateRecentItem does not delete into core data.");
//                            /// TODO REDO
//                        }
//                    }
//				}];
//			}
//		}
//		else NSLog(@"DeleteMessages query error.");
//	}];
//}

#import "UserRemoteUtil.h"
#define BASE_REMOTE_UTIL_OBJ_TYPE ObjectEntity*

@implementation RecentRemoteUtil

+ (RecentRemoteUtil *)sharedUtil {
    static dispatch_once_t predicate = 0;
    static RecentRemoteUtil *sharedObject;
    
    dispatch_once(&predicate, ^{
        //initializing singleton object
        sharedObject = [[self alloc] init];
        
        sharedObject.className = PF_RECENT_CLASS_NAME;
    });
    return sharedObject;
}

- (void) setCommonObject:(BASE_REMOTE_UTIL_OBJ_TYPE)object withRemoteObject:(RemoteObject *)remoteObj inManagedObjectContext: (NSManagedObjectContext *)context{
    NSAssert([object isKindOfClass:[Recent class]], @"Type casting is wrong");
    Recent * recent = (Recent *)object;

    //recent.user = [[UserRemoteUtil sharedUtil] convertToUser:remoteObj[PF_RECENT_USER] inManagedObjectContext:context];
    recent.chatID = remoteObj[PF_RECENT_GROUPID];
    recent.members = [NSArray arrayWithArray:remoteObj[PF_RECENT_MEMBERS]] ;
    recent.details = remoteObj[PF_RECENT_DESCRIPTION] ;
    recent.lastUser = [[UserRemoteUtil sharedUtil] convertToUser:remoteObj[PF_RECENT_LASTUSER]];
    recent.lastMessage = remoteObj[PF_RECENT_LASTMESSAGE] ;
    recent.counter = remoteObj[PF_RECENT_COUNTER] ;
    
}

- (void) setCommonRemoteObject:(RemoteObject *)remoteObj withAlert:(BASE_REMOTE_UTIL_OBJ_TYPE)object {
    NSAssert([object isKindOfClass:[Recent class]], @"Type casting is wrong");
    Recent * recent = (Recent *)object;
    
//    remoteObj[PF_RECENT_USER] = [[UserRemoteUtil sharedUtil] convertToRemoteUser:recent.user];
    remoteObj[PF_RECENT_USER] = [PFUser currentUser];
    remoteObj[PF_RECENT_GROUPID] = recent.chatID;
    remoteObj[PF_RECENT_MEMBERS] = [NSArray arrayWithArray:recent.members];
    remoteObj[PF_RECENT_DESCRIPTION] = recent.details;
    remoteObj[PF_RECENT_LASTUSER] = [[UserRemoteUtil sharedUtil] convertToRemoteUser:recent.lastUser];
    remoteObj[PF_RECENT_LASTMESSAGE] = recent.lastMessage;
    remoteObj[PF_RECENT_COUNTER] = recent.counter;
    
}




- (void) loadRecentFromParse:(Recent *) latestRecent completionHandler:(REMOTE_ARRAY_BLOCK)block  {

    
    // load from parse
    PFQuery *query = [PFQuery queryWithClassName:PF_RECENT_CLASS_NAME];
    [query whereKey:PF_RECENT_USER equalTo:[PFUser currentUser]];
    [query includeKey:PF_RECENT_LASTUSER];
    [query setLimit:RECENTVIEW_ITEM_NUM];
    [query orderByDescending:PF_COMMON_UPDATE_TIME];
    
    if (latestRecent) {
        //found any recent itme
        [query whereKey:PF_COMMON_UPDATE_TIME greaterThan:latestRecent.updateTime];
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

- (void) loadRemoteRecent:(Recent *) latestRecent completionHandler:(REMOTE_ARRAY_BLOCK)block  {
    [self loadRemoteRecent:latestRecent completionHandler:block];
}

- (NSString *) startRemotePrivateChat:(User *)user1 user2:(User *)user2 {
    NSString *id1 = user1.globalID;
    NSString *id2 = user2.globalID;
    //---------------------------------------------------------------------------------------------------------------------------------------------
    NSString *groupId = ([id1 compare:id2] < 0) ? [NSString stringWithFormat:@"%@%@", id1, id2] : [NSString stringWithFormat:@"%@%@", id2, id1];
    //---------------------------------------------------------------------------------------------------------------------------------------------
    NSArray *members = @[user1.globalID, user2.globalID];
    //---------------------------------------------------------------------------------------------------------------------------------------------
    //CreateRecentItem(user1, groupId, members, user2.fullname, context);
    //CreateRecentItem(user2, groupId, members, user1.fullname, context);
    [self createRemoteRecentItem:user1 groupId:groupId members:members desciption:user2.fullname lastMessage:nil];
    [self createRemoteRecentItem:user2 groupId:groupId members:members desciption:user1.fullname lastMessage:nil];

    //---------------------------------------------------------------------------------------------------------------------------------------------
    return groupId;
}
- (NSString *) startRemoteMultipleChat:(NSMutableArray *)users {
    NSString *groupId = @"";
    NSString *description = @"";
    
    // add current user
    if (![users containsObject:[[ConfigurationManager sharedManager] getCurrentUser]]) {
        [users addObject:[[ConfigurationManager sharedManager] getCurrentUser]];
    }
    
    
    //user Ids
    NSMutableArray *userIds = [[NSMutableArray alloc] init];
    for (User *user in users) {
        [userIds addObject: user.globalID];
    }
    //sort user id
    NSArray *sorted = [userIds sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    
    // Create group id
    for (NSString *userId in sorted) {
        groupId = [groupId stringByAppendingString:userId];
    }
    
    //create description
    for (User *user in users) {
        if ([description length] != 0) description = [description stringByAppendingString:@" & "];
        description = [description stringByAppendingString:user.fullname];
    }

    //create recent item
    for (User *user in users) {
        //CreateRecentItem(user, groupId, userIds, description, context);
        [self createRemoteRecentItem:user groupId:groupId members:userIds desciption:description lastMessage:nil];
    }

    //---------------------------------------------------------------------------------------------------------------------------------------------
    return groupId;
}


- (void) createRemoteRecentItem:(User *)user  groupId:(NSString *)groupId members:(NSArray *)members desciption:(NSString *)description lastMessage:(NSString *)lastMessage {
    PFQuery *query = [PFQuery queryWithClassName:PF_RECENT_CLASS_NAME];
    [query whereKey:PF_RECENT_USER equalTo:[[UserRemoteUtil sharedUtil] convertToRemoteUser:user] ];
    [query whereKey:PF_RECENT_GROUPID equalTo:groupId];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (error == nil) {
            Recent * recent = nil;
            if ([objects count] == 0) {
                // create a new chat
                recent = [Recent createEntity:nil];
                
                recent.userVolatile = user;
                recent.chatID = groupId;
                recent.members = members;
                recent.details = description;
                recent.lastUser = [[ConfigurationManager sharedManager] getCurrentUser];
                if ([lastMessage length]) {
                    recent.lastMessage = lastMessage;
                    recent.counter = @1;
                }
                else {
                    recent.lastMessage = @"";
                    recent.counter = @0;
                }

                if ([user isEqual:[[ConfigurationManager sharedManager] getCurrentUser]]) {
                    [self uploadCreateRemoteObject:recent completionHandler:nil];
                }
                else {
                    // not current user's data, so not create entity
                    [self uploadCreateRemoteObject:recent localSyncs:NO completionHandler:nil];
                }

                
            }
            else {
                //already exist
                NSAssert([objects count]>1, @"recent item is not unique remotely");
                //recent = [objects firstObject];
                //block(recent, nil);
            }
        }
        else {
            NSLog(@"CreateRecentItem query error.");
            [ProgressHUD showError:@"Network error."];
        }
        
    }];
}


- (void) updateRemoteRecentAndCounter:(NSString *)groupId amount:(NSInteger)amount lastMessage:(NSString *)lastMessage members:(NSArray *)members {
    PFQuery *query = [PFQuery queryWithClassName:PF_RECENT_CLASS_NAME];
    [query whereKey:PF_RECENT_GROUPID equalTo:groupId];
    [query includeKey:PF_RECENT_USER];
    //[query setLimit:1000];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (error == nil) {
            // member ids
            NSMutableSet * memberIDs = [NSMutableSet setWithArray:members];
            
            int count = 0;
            // for all the remote objects that are existent
            for (PFObject *recentRMT in objects) {
                
                if ([recentRMT[PF_RECENT_USER] isEqualTo:[PFUser currentUser]] == NO) {
                    // update the counter of others only
                    [recentRMT incrementKey:PF_RECENT_COUNTER byAmount:[NSNumber numberWithInteger:amount]];
                }

                recentRMT[PF_RECENT_LASTUSER] = [PFUser currentUser];
                recentRMT[PF_RECENT_LASTMESSAGE] = lastMessage;
                //recentRMT[PF_RECENT_UPDATEDACTION] = [NSDate date];
                
                if ([recentRMT[PF_RECENT_USER] isEqualTo:[PFUser currentUser]]) {
                    Recent * recent = [Recent entityWithID:recentRMT.objectId inManagedObjectContext:self.managedObjectContext];
                    [self uploadUpdateRemoteObject:recentRMT modifyObject:recent completionHandler:nil];
                }
                else {
                    [self uploadUpdateRemoteObject:recentRMT modifyObject:nil completionHandler:nil];
                }
                
                //remove this member id
                PFUser* userRMT = recentRMT[PF_RECENT_USER];
                [memberIDs removeObject:userRMT.objectId];
                

                count++;
            }
            
            // for all the rest of remote objects that have been deleted by other users
            NSString * description = @"";
            for (NSString * userID in members) {
                User * user = [[UserManager sharedUtil] getUser:userID];
                if ([description length] != 0) {
                    description = [description stringByAppendingString:@" & "];
                }
                description = [description stringByAppendingString:user.fullname];
            }
            for (NSString * userID in memberIDs) {
                [self createRemoteRecentItem:[[UserManager sharedUtil] getUser:userID] groupId:groupId members:members desciption:description  lastMessage:lastMessage];
            }
            ///TODO if not existed, we need create one recent item for that user
            //use sorted user and update the user group each update, eventually the rest of user group is the ones to be created
        }
        else {
            NSLog(@"UpdateRecentCounter query error.");
        }
    }];

}

- (void) clearRemoteRecentCounter:(NSString *)groupId {
    PFQuery *query = [PFQuery queryWithClassName:PF_RECENT_CLASS_NAME];
    [query whereKey:PF_RECENT_GROUPID equalTo:groupId];
    [query whereKey:PF_RECENT_USER equalTo:[PFUser currentUser]];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (error == nil) {
            for (PFObject *recentRMT in objects) {
                recentRMT[PF_RECENT_COUNTER] = @0;
                if ([recentRMT[PF_RECENT_USER] isEqualTo:[PFUser currentUser]]) {
                    Recent * recent = [Recent entityWithID:recentRMT.objectId inManagedObjectContext:self.managedObjectContext];
                    [self uploadUpdateRemoteObject:recentRMT modifyObject:recent completionHandler:nil];
                }
                else {
                    [self uploadUpdateRemoteObject:recentRMT modifyObject:nil completionHandler:nil];
                }
            }
        }
        else {
            NSLog(@"UpdateRecentCounter query error.");
        }
    }];
}

- (void) deleteRemoteRecentItem:(User *)user1 user2:(User *)user2 {
    PFQuery *query = [PFQuery queryWithClassName:PF_RECENT_CLASS_NAME];
    [query whereKey:PF_RECENT_USER equalTo: [[UserRemoteUtil sharedUtil] convertToRemoteUser:user1] ];
    [query whereKey:PF_RECENT_MEMBERS equalTo:user2.globalID];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
         if (error == nil) {
             for (PFObject *recentRMT in objects) {
                 
                 if ([recentRMT[PF_RECENT_USER] isEqualTo:[PFUser currentUser]]) {
                     Recent * recent = [Recent entityWithID:recentRMT.objectId inManagedObjectContext:self.managedObjectContext];
                     [self uploadRemoveRemoteObject:recent completionHandler:nil];
                 }
                 else {
                     [recentRMT deleteInBackgroundWithBlock:nil];
                 }
             }
         }
         else {
             NSLog(@"DeleteMessages query error.");
         }
     }];
}

- (void) deleteRemoteRecent:(Recent *)recent completionHandler:(REMOTE_BOOL_BLOCK)block {
    
    [self uploadRemoveRemoteObject:recent completionHandler:block];
}



@end
