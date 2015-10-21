//
//  EventRemoteUtil.m
//  MyApp
//
//  Created by Linwei Ding on 10/19/15.
//  Copyright (c) 2015 AppsFoundation. All rights reserved.
//
#import "Event+Util.h"
#import "AppHeader.h"
#import "UserRemoteUtil.h"
#import "User+Util.h"
#import "Alert+Util.h"
#import "EventRemoteUtil.h"

@implementation EventRemoteUtil

- (void) setRemoteEvent:(RemoteObject *)object withEvent:(Event *)event {

    if ([event.globalID length]) {
        object[PF_EVENT_OBJECTID] = event.globalID;
    }
    
    /// TODO may not need update user here
    
    //object.createdAt = event.createTime;
    //object.updatedAt  = event.updateTime ;
    object[PF_EVENT_START_TIME] = event.startTime ;
    object[PF_EVENT_END_TIME] = event.endTime ;
    object[PF_EVENT_INVITEES] = event.invitees ;
    object[PF_EVENT_IS_ALERT] = event.isAlert ;
    object[PF_EVENT_LOCATION] = event.location ;
    object[PF_EVENT_NOTES] = event.notes ;
    object[PF_EVENT_TITLE] = event.title ;
    object[PF_EVENT_SCOPE] = event.scope ;
    object[PF_EVENT_BOARD_IDS] = event.boardIDs ;    //array
    object[PF_EVENT_VOTING_ID] = event.votingID ;
    object[PF_EVENT_MEMBERS] = event.members ;
    object[PF_EVENT_GROUP_IDS] = event.groupIDs ;
    object[PF_EVENT_IS_VOTING] = event.isVoting ;
    
    event.alert = nil;  //generate new alert
    event.place = nil;  //generate a new place
    
    object[PF_EVENT_CREATE_USER] = [User convertToRemoteUser:event.user];
    event.category = nil;   //get a new category
    
}


- (void) setEvent:(Event *)event withRemoteObject:(RemoteObject *)object inManagedObjectContext: (NSManagedObjectContext *)context{
    event.globalID = object[PF_EVENT_OBJECTID];
    
    /// TODO may not need update user here
    

    
    event.createTime = object.createdAt ;
    event.updateTime = object.updatedAt ;
    event.startTime = object[PF_EVENT_START_TIME];
    event.endTime = object[PF_EVENT_END_TIME];
    event.invitees = object[PF_EVENT_INVITEES];
    event.isAlert = object[PF_EVENT_IS_ALERT];
    event.location = object[PF_EVENT_LOCATION];
    event.notes = object[PF_EVENT_NOTES];
    event.title = object[PF_EVENT_TITLE];
    event.scope = object[PF_EVENT_SCOPE];
    event.boardIDs = object[PF_EVENT_BOARD_IDS];    //array
    event.votingID = object[PF_EVENT_VOTING_ID];
    event.members = object[PF_EVENT_MEMBERS];
    event.groupIDs = object[PF_EVENT_GROUP_IDS];
    event.isVoting = object[PF_EVENT_IS_VOTING];
    
    if (event.alert) {
        [self setAlert:event.alert withRemoteObject:object inManagedObjectContext:context];
    }
    else {
        event.alert = [Alert createEntity:context];
    }
    //event.alert = nil;  //generate new alert
    
    event.place = nil;  //generate a new place
    
    User * user = [User convertFromRemoteUser:object[PF_EVENT_CREATE_USER] inManagedObjectContext:context];
    event.user = user;
    event.category = nil;   //get a new category
    
}

- (void) setAlert:(Alert *)alert withRemoteObject:(RemoteObject *)object inManagedObjectContext: (NSManagedObjectContext *)context {
    alert.globalID = object[PF_ALERT_CLASS_NAME];
    alert.createTime = object[PF_ALERT_CREATE_TIME];
    alert.updateTime = object[PF_ALERT_UPDATE_TIME];
    alert.time = object[PF_ALERT_TIME];
    alert.type = object[PF_ALERT_TYPE];
}



+ (EventRemoteUtil *)sharedUtil {
    static dispatch_once_t predicate = 0;
    static EventRemoteUtil *sharedObject;
    
    dispatch_once(&predicate, ^{
        //initializing singleton object
        sharedObject = [[self alloc] init];
        
    });
    return sharedObject;
}



- (void) loadRemoteUsersByEvent:(Event *)event  completionHandler:(REMOTE_ARRAY_BLOCK)block{
    PFQuery *query = [PFQuery queryWithClassName:PF_USER_CLASS_NAME];
	[query whereKey:PF_USER_OBJECTID containedIn:event.members];
	[query orderByAscending:PF_USER_FULLNAME];
	[query setLimit:EVENTVIEW_ITEM_NUM];
	[query findObjectsInBackgroundWithBlock:block];
}

- (void) loadRemoteEvents:(Event *)latestEvent completionHandler:(REMOTE_ARRAY_BLOCK)block {
    [self loadEventsFromParse:latestEvent completionHandler:block];
}

- (void) loadEventsFromParse:(Event *)latestEvent completionHandler:(REMOTE_ARRAY_BLOCK)block {
    
    
	PFUser *user = [PFUser currentUser];
    
	PFQuery *query = [PFQuery queryWithClassName:PF_EVENT_CLASS_NAME];
	[query whereKey:PF_EVENT_MEMBERS equalTo:user.objectId];
    
    [query includeKey:PF_EVENT_CREATE_USER];
    
    [query orderByDescending:PF_EVENT_START_TIME];
    
    if (latestEvent) {
        //found any recent itme
        [query whereKey:PF_EVENT_UPDATE_TIME greaterThan:latestEvent.updateTime];
    }
    
	[query findObjectsInBackgroundWithBlock:block];
    
}

- (void) createRemoteEvent:(Event *)event completionHandler:(REMOTE_BOOL_BLOCK)block {
    [self createPFEvent:event completionHandler:block];
}

- (void) createPFEvent:(Event *)event completionHandler:(REMOTE_BOOL_BLOCK)block {
    PFObject *object = [PFObject objectWithClassName:PF_EVENT_CLASS_NAME];

    [self setRemoteEvent:object withEvent:event];
	[object saveInBackgroundWithBlock:block];
}


//-------------------------------------------------------------------------------------------------------------------------------------------------
// delete the user in the event
- (void) removeEventMember:(Event *)event user:(User *)user completionHandler:(REMOTE_BOOL_BLOCK)block {
    //PFObject * eventPF = [PFObject objectWithoutDataWithClassName:PF_EVENT_CLASS_NAME objectId:event.globalID];
    //[eventPF getO]
    
    PFQuery *query = [PFQuery queryWithClassName:PF_EVENT_CLASS_NAME];
    [query getObjectInBackgroundWithId:event.globalID block:^(PFObject *object, NSError *error) {
        if ([object[PF_EVENT_MEMBERS] containsObject:user.globalID])
        {
            if ([object[PF_EVENT_MEMBERS] count] == 1) {
                // only the user is left, delete the remote object
                [object deleteInBackgroundWithBlock:block];
            }
            else {
                // other users are left, just remove the member of the user
                [object[PF_EVENT_MEMBERS] removeObject:user.globalID];
                [object saveInBackgroundWithBlock:block];
            }
        }
    }];
}

// delete the event
- (void) removeEventItem:(Event *) event completionHandler:(REMOTE_BOOL_BLOCK)block {
    PFQuery *query = [PFQuery queryWithClassName:PF_EVENT_CLASS_NAME];
    [query getObjectInBackgroundWithId:event.globalID block:^(PFObject *object, NSError *error) {
        [object deleteInBackgroundWithBlock:block];
    }];
}

@end
