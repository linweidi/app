//
//  PlaceRemoteUtil.m
//  MyApp
//
//  Created by Linwei Ding on 10/21/15.
//  Copyright (c) 2015 Linweiding. All rights reserved.
//

#import "PlaceRemoteUtil.h"

@implementation PlaceRemoteUtil

- (void) setRemotePlace:(RemoteObject *)object withEvent:(Event *)event {
    
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
    
#warning this may be not right
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
@end
