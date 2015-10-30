//
//  EventRemoteUtil.m
//  MyApp
//
//  Created by Linwei Ding on 10/19/15.
//  Copyright (c) 2015 AppsFoundation. All rights reserved.
//
#import "Event+Util.h"
#import "AppHeader.h"
#import "User+Util.h"
#import "Alert+Util.h"
#import "Place+Util.h"
#import "UserEntity.h"
#import "Recent+Util.h"
#import "EventCategory+Util.h"
#import "AlertRemoteUtil.h"
#import "PlaceRemoteUtil.h"
#import "UserRemoteUtil.h"
#import "EventRemoteUtil.h"
#import "CurrentUser+Util.h"

#define BASE_REMOTE_UTIL_OBJ_TYPE ObjectEntity*

@implementation EventRemoteUtil

+ (EventRemoteUtil *)sharedUtil {
    static dispatch_once_t predicate = 0;
    static EventRemoteUtil *sharedObject;
    
    dispatch_once(&predicate, ^{
        //initializing singleton object
        sharedObject = [[self alloc] init];
        
        sharedObject.className = PF_EVENT_CLASS_NAME;
    });
    return sharedObject;
}

- (void) setCommonObject:(BASE_REMOTE_UTIL_OBJ_TYPE)object withRemoteObject:(RemoteObject *)remoteObj inManagedObjectContext: (NSManagedObjectContext *)context{
    NSAssert([object isKindOfClass:[Event class]], @"Type casting is wrong");
    Event * event = (Event *)object;
    event.startTime  = remoteObj[PF_EVENT_START_TIME] ;
    event.endTime  = remoteObj[PF_EVENT_END_TIME] ;
     event.invitees = remoteObj[PF_EVENT_INVITEES] ;
    event.isAlert = remoteObj[PF_EVENT_IS_ALERT] ;
    event.location  = remoteObj[PF_EVENT_LOCATION] ;
    event.notes  = remoteObj[PF_EVENT_NOTES] ;
    event.title = remoteObj[PF_EVENT_TITLE] ;
    event.scope  = remoteObj[PF_EVENT_SCOPE] ;
    event.boardIDs  = remoteObj[PF_EVENT_BOARD_IDS] ;    //array
    event.votingID  = remoteObj[PF_EVENT_VOTING_ID] ;
    event.members  = remoteObj[PF_EVENT_MEMBERS] ;
    event.groupIDs  = remoteObj[PF_EVENT_GROUP_IDS] ;
    event.isVoting  = remoteObj[PF_EVENT_IS_VOTING] ;
    
    event.user = [[UserRemoteUtil sharedUtil] convertToUser:remoteObj[PF_EVENT_CREATE_USER] inManagedObjectContext:context];
}

- (void) setCommonRemoteObject:(RemoteObject *)remoteObj withAlert:(BASE_REMOTE_UTIL_OBJ_TYPE)object {
    NSAssert([object isKindOfClass:[Event class]], @"Type casting is wrong");
    Event * event = (Event *)object;
    remoteObj[PF_EVENT_START_TIME] = event.startTime ;
    remoteObj[PF_EVENT_END_TIME] = event.endTime ;
    remoteObj[PF_EVENT_INVITEES] = event.invitees ;
    remoteObj[PF_EVENT_IS_ALERT] = event.isAlert ;
    remoteObj[PF_EVENT_LOCATION] = event.location ;
    remoteObj[PF_EVENT_NOTES] = event.notes ;
    remoteObj[PF_EVENT_TITLE] = event.title ;
    remoteObj[PF_EVENT_SCOPE] = event.scope ;
    remoteObj[PF_EVENT_BOARD_IDS] = event.boardIDs ;    //array
    remoteObj[PF_EVENT_VOTING_ID] = event.votingID ;
    remoteObj[PF_EVENT_MEMBERS] = event.members ;
    remoteObj[PF_EVENT_GROUP_IDS] = event.groupIDs ;
    remoteObj[PF_EVENT_IS_VOTING] = event.isVoting ;
    
    remoteObj[PF_EVENT_CREATE_USER] = [[UserRemoteUtil sharedUtil] convertToRemoteUser:event.user];
    
}

- (void)setNewRemoteObject:(RemoteObject *)remoteObj withObject:(UserEntity *)object {
    [super setNewRemoteObject:remoteObj withObject:object];
    NSAssert([object isKindOfClass:[Event class]], @"Type casting is wrong");
    Event * event = (Event *)object;
    
    PFObject * alertPF = [PFObject objectWithClassName:PF_ALERT_CLASS_NAME];
    [[AlertRemoteUtil sharedUtil] setNewRemoteObject:alertPF withObject:event.alert];
    remoteObj[PF_EVENT_ALERT] = alertPF;
    
    PFObject * placePF = [PFObject objectWithoutDataWithClassName:PF_PLACE_CLASS_NAME objectId:event.place.globalID];
    remoteObj[PF_EVENT_PLACE] = placePF;

    
    PFObject * categoryPF = [PFObject objectWithoutDataWithClassName:PF_EVENT_CATEGORY_CLASS_NAME objectId:event.category.globalID];
    remoteObj[PF_EVENT_PLACE] = categoryPF;   //get a new category
}

- (void)setExistedRemoteObject:(RemoteObject *)remoteObj withObject:(UserEntity *)object {
    [super setExistedRemoteObject:remoteObj withObject:object];
    NSAssert([object isKindOfClass:[Event class]], @"Type casting is wrong");
    //Event * event = (Event *)object;
    
//    PFObject * alertPF = [PFObject objectWithoutDataWithClassName:PF_EVENT_ALERT objectId:event.alert.globalID];
//    remoteObj[PF_EVENT_ALERT] = alertPF;  //generate new alert
//    
//    PFObject * placePF = [PFObject objectWithoutDataWithClassName:PF_EVENT_PLACE objectId:event.place.globalID];
//    remoteObj[PF_EVENT_PLACE] = placePF;
//    
//    remoteObj[PF_EVENT_CREATE_USER] =[[UserRemoteUtil sharedUtil] convertToRemoteUser:event.user];
//    
//    PFObject * cateogoryPF = [PFObject objectWithoutDataWithClassName:PF_EVENT_CATEGORY objectId:event.category.globalID];
//    remoteObj[PF_EVENT_CATEGORY] = cateogoryPF;   //get a new category
    NSAssert(NO, @"should not user setExistedRemoteObject");
}

- (void)setNewObject:(UserEntity *)object withRemoteObject:(RemoteObject *)remoteObj inManagedObjectContext:(NSManagedObjectContext *)context {
    [super setNewObject:object withRemoteObject:remoteObj inManagedObjectContext:context];
    NSAssert([object isKindOfClass:[Event class]], @"Type casting is wrong");
    Event * event = (Event *)object;
    
    // alert
    event.alert = [Alert createEntity:context];
    [[AlertRemoteUtil sharedUtil] setNewObject:event.alert withRemoteObject:remoteObj[PF_EVENT_ALERT] inManagedObjectContext:context];
    
    // place
    PFObject * placePF = remoteObj[PF_EVENT_PLACE];
    event.place = [Place entityWithID:placePF.objectId inManagedObjectContext:context];
    
    // category
    PFObject * categoryPF = remoteObj[PF_EVENT_CATEGORY];
    event.category = [EventCategory entityWithID:categoryPF.objectId inManagedObjectContext:context];
}

- (void)setExistedObject:(UserEntity *)object withRemoteObject:(RemoteObject *)remoteObj inManagedObjectContext:(NSManagedObjectContext *)context {
    [super setExistedObject:object withRemoteObject:remoteObj inManagedObjectContext:context];
    NSAssert([object isKindOfClass:[Event class]], @"Type casting is wrong");
    Event * event = (Event *)object;
    
    [[AlertRemoteUtil sharedUtil] setExistedObject:event.alert withRemoteObject:remoteObj[PF_EVENT_ALERT] inManagedObjectContext:context];
    
    // place
    PFObject * placePF = remoteObj[PF_EVENT_PLACE];
    event.place = [Place entityWithID:placePF.objectId inManagedObjectContext:context];
    
    // category
    PFObject * categoryPF = remoteObj[PF_EVENT_CATEGORY];
    event.category = [EventCategory entityWithID:categoryPF.objectId inManagedObjectContext:context];
}

- (void) loadRemoteUsersByEvent:(Event *)event  completionHandler:(REMOTE_ARRAY_BLOCK)block{
    PFQuery *query = [PFUser query];
	[query whereKey:PF_USER_OBJECTID containedIn:event.members];
	[query orderByAscending:PF_USER_FULLNAME];
	[query setLimit:EVENTVIEW_ITEM_NUM];
	[query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        NSArray * userObjArray = [[UserRemoteUtil sharedUtil] convertToUserArray:objects inManagedObjectContext:self.managedObjectContext];
//        for (PFUser * object in objects) {
//
//        }
        block(userObjArray, error);
    }];
}

- (void) loadRemoteEvents:(Event *)latestEvent completionHandler:(REMOTE_ARRAY_BLOCK)block {
    //[self loadRemoteEventsFromParse:latestEvent completionHandler:block];
    
    PFQuery *query = [PFQuery queryWithClassName:PF_EVENT_CLASS_NAME];
    [query whereKey:PF_EVENT_CREATE_USER equalTo:[PFUser currentUser]];
	[query includeKey:PF_EVENT_CREATE_USER];
	[query setLimit:EVENTVIEW_ITEM_NUM];
    
    [query orderByDescending:PF_EVENT_START_TIME];
    
    if (latestEvent) {
        //found any recent itme
        [query whereKey:PF_COMMON_UPDATE_TIME greaterThan:latestEvent.updateTime];
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



//-------------------------------------------------------------------------------------------------------------------------------------------------
// delete the user in the event
- (void) removeRemoteEventMember:(Event *)event user:(User *)user completionHandler:(REMOTE_BOOL_BLOCK)block {

    [self downloadUpdateObject:event includeKeys:nil completionHandler:^(PFObject *remoteObj, id object, NSError *error) {
        if ([remoteObj[PF_EVENT_MEMBERS] containsObject:user.globalID])
        {
            if ([remoteObj[PF_EVENT_MEMBERS] count] == 1) {
                // only the user is left, delete the remote object
                [self uploadRemoveRemoteObject:event completionHandler:block];
                //[object deleteInBackgroundWithBlock:block];
            }
            else {
                // other users are left, just remove the member of the user
                [remoteObj[PF_EVENT_MEMBERS] removeObject:user.globalID];
                [self uploadUpdateRemoteObject:remoteObj modifiedObject:event completionHandler:^(id object, NSError *error) {
                    block(!error, error);
                }];
            }
        }
    }];
    
    
//    PFQuery *query = [PFQuery queryWithClassName:PF_EVENT_CLASS_NAME];
//    [query getObjectInBackgroundWithId:event.globalID block:^(PFObject *object, NSError *error) {
//        if ([object[PF_EVENT_MEMBERS] containsObject:user.globalID])
//        {
//            if ([object[PF_EVENT_MEMBERS] count] == 1) {
//                // only the user is left, delete the remote object
//                [object deleteInBackgroundWithBlock:block];
//            }
//            else {
//                // other users are left, just remove the member of the user
//                [object[PF_EVENT_MEMBERS] removeObject:user.globalID];
//                [object saveInBackgroundWithBlock:block];
//            }
//        }
//    }];
}

- (NSString *) startPrivateChat:(User *)user1 user2:(User *)user2 {
    NSString *id1 = user1.globalID;
	NSString *id2 = user2.globalID;
	//---------------------------------------------------------------------------------------------------------------------------------------------
	NSString *groupId = ([id1 compare:id2] < 0) ? [NSString stringWithFormat:@"%@%@", id1, id2] : [NSString stringWithFormat:@"%@%@", id2, id1];
	//---------------------------------------------------------------------------------------------------------------------------------------------
	NSArray *members = @[user1.globalID, user2.globalID];
	//---------------------------------------------------------------------------------------------------------------------------------------------
	//CreateRecentItem(user1, groupId, members, user2.fullname, context);
	//CreateRecentItem(user2, groupId, members, user1.fullname, context);
    [self createRemoteRecentItem:user1 groupId:groupId members:members desciption:user2.fullname];
    [self createRemoteRecentItem:user2 groupId:groupId members:members desciption:user1.fullname];
	//---------------------------------------------------------------------------------------------------------------------------------------------
	return groupId;
}
- (NSString *) startMultipleChat:(NSMutableArray *)users {
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
        [self createRemoteRecentItem:user groupId:groupId members:userIds desciption:description];
	}
	//---------------------------------------------------------------------------------------------------------------------------------------------
	return groupId;
}

- (void) createRemoteRecentItem:(User *)user  groupId:(NSString *)groupId members:(NSArray *)members desciption:(NSString *)description {
    PFQuery *query = [PFQuery queryWithClassName:PF_RECENT_CLASS_NAME];
	[query whereKey:PF_RECENT_USER equalTo:[[UserRemoteUtil sharedUtil] convertToRemoteUser:user] ];
	[query whereKey:PF_RECENT_GROUPID equalTo:groupId];
	[query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
         if (error == nil) {
             Recent * recent = nil;
             if ([objects count] == 0) {
                 // create a new chat
                 recent = [Recent createEntity:nil];
                 
                 recent.user = user;
                 recent.chatID = groupId;
                 recent.members = members;
                 recent.details = description;
                 recent.lastUser = [[ConfigurationManager sharedManager] getCurrentUser];
                 recent.lastMessage = @"";
                 recent.counter = @0;
                 [self uploadCreateRemoteObject:recent completionHandler:^(id object, NSError *error) {
                     //nil temp
                 }];

             }
             else {
                 //already exist
                 NSAssert([objects count]>1, @"recent item is not unique remotely");
                 recent = [objects firstObject];
                 //block(recent, nil);
             }
         }
         else {
             NSLog(@"CreateRecentItem query error.");
             [ProgressHUD showError:@"Network error."];
         }
         
     }];
}

// delete the event
- (void) deleteRemoteEventItem:(Event *) event completionHandler:(REMOTE_BOOL_BLOCK)block {
    [self uploadRemoveRemoteObject:event completionHandler:block];
}

@end
