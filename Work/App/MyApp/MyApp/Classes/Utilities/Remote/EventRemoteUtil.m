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
    
    //event.user = [[UserRemoteUtil sharedUtil] convertToUser:remoteObj[PF_EVENT_CREATE_USER] inManagedObjectContext:context];
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
    
    //remoteObj[PF_EVENT_CREATE_USER] = [[UserRemoteUtil sharedUtil] convertToRemoteUser:event.user];
    remoteObj[PF_EVENT_CREATE_USER] = [PFUser currentUser];
    
}

- (void)setNewRemoteObject:(RemoteObject *)remoteObj withObject:(UserEntity *)object {
    [super setNewRemoteObject:remoteObj withObject:object];
    NSAssert([object isKindOfClass:[Event class]], @"Type casting is wrong");
    Event * event = (Event *)object;
    
    if (event.alert) {
        PFObject * alertPF = [PFObject objectWithClassName:PF_ALERT_CLASS_NAME];
        [[AlertRemoteUtil sharedUtil] setNewRemoteObject:alertPF withObject:event.alert];
        remoteObj[PF_EVENT_ALERT] = alertPF;
    }

    if (event.place) {
        PFObject * placePF = [PFObject objectWithoutDataWithClassName:PF_PLACE_CLASS_NAME objectId:event.place.globalID];
        remoteObj[PF_EVENT_PLACE] = placePF;
    }

    if (event.category) {
        PFObject * categoryPF = [PFObject objectWithoutDataWithClassName:PF_EVENT_CATEGORY_CLASS_NAME objectId:event.category.globalID];
        remoteObj[PF_EVENT_PLACE] = categoryPF;   //get a new category
    }
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

    PFObject * alertRMT = remoteObj[PF_EVENT_ALERT];
    if (alertRMT.updatedAt) {
        event.alert = [Alert createEntity:context];
        [[AlertRemoteUtil sharedUtil] setNewObject:event.alert withRemoteObject: alertRMT inManagedObjectContext:context];
    }

    
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
    
    //alert
    PFObject * alertRMT = remoteObj[PF_EVENT_ALERT];
    if (alertRMT.updatedAt) {
        Alert * alert = event.alert;
        if (alert) {
            if ([alertRMT.updatedAt compare:alert.updateTime] == NSOrderedDescending) {
                [[AlertRemoteUtil sharedUtil] setExistedObject:alert withRemoteObject:remoteObj[PF_EVENT_ALERT] inManagedObjectContext:context];
            }
        }
        else {
            alert = [Alert createEntity:self.managedObjectContext];
            [[AlertRemoteUtil sharedUtil] setNewObject:alert withRemoteObject:remoteObj[PF_EVENT_ALERT] inManagedObjectContext:context];
        }
        event.alert = alert;
    }
    
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
        NSArray * userObjArray = [[UserRemoteUtil sharedUtil] convertToUserArray:objects];
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
                [self uploadUpdateRemoteObject:remoteObj modifyObject:event completionHandler:^(id object, NSError *error) {
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


// delete the event
- (void) deleteRemoteEventItem:(Event *) event completionHandler:(REMOTE_BOOL_BLOCK)block {
    [self uploadRemoveRemoteObject:event completionHandler:block];
}

@end
