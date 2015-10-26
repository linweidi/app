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
#import "Place+Util.h"
#import "EventCategory+Util.h"
#import "AlertRemoteUtil.h"
#import "EventRemoteUtil.h"

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
}

- (void)setNewRemoteObject:(RemoteObject *)remoteObj withObject:(UserEntity *)object {
    [super setNewRemoteObject:remoteObj withObject:object];
    NSAssert([object isKindOfClass:[Event class]], @"Type casting is wrong");
    Event * event = (Event *)object;
    
    PFObject * alertPF = [PFObject objectWithClassName:PF_ALERT_CLASS_NAME];
    [[AlertRemoteUtil sharedUtil] setNewRemoteObject:alertPF withObject:event.alert];
    remoteObj[PF_EVENT_ALERT] = alertPF;
    
    PFObject * placePF = [PFObject objectWithClassName:PF_PLACE_CLASS_NAME];
    [[PlaceRemoteUtil sharedUtil] setExistedRemoteObject:placePF withObject:event.alert];
    placePF
    remoteObj[PF_EVENT_PLACE] = placePF;
    
    remoteObj[PF_EVENT_CREATE_USER] = [[UserRemoteUtil sharedUtil] convertToRemoteUser:event.user];
    
    PFObject * categoryPF = [PFObject objectWithClassName:PF_EVENT_CATEGORY_CLASS_NAME];
    [[EventCategoryRemoteUtil sharedUtil] setExistedRemoteObject:categoryPF withObject:event.category];
    remoteObj[PF_EVENT_PLACE] = categoryPF;   //get a new category
}

- (void)setExistedRemoteObject:(RemoteObject *)remoteObj withObject:(UserEntity *)object {
    [super setExistedRemoteObject:remoteObj withObject:object];
    NSAssert([object isKindOfClass:[Event class]], @"Type casting is wrong");
    Event * event = (Event *)object;
    
    PFObject * alertPF = [PFObject objectWithoutDataWithClassName:PF_EVENT_ALERT objectId:event.alert.globalID];
    remoteObj[PF_EVENT_ALERT] = alertPF;  //generate new alert
    
    PFObject * placePF = [PFObject objectWithoutDataWithClassName:PF_EVENT_PLACE objectId:event.place.globalID];
    remoteObj[PF_EVENT_PLACE] = placePF;
    
    remoteObj[PF_EVENT_CREATE_USER] = [User convertToRemoteUser:event.user];
    
    PFObject * cateogoryPF = [PFObject objectWithoutDataWithClassName:PF_EVENT_CATEGORY objectId:event.category.globalID];
    remoteObj[PF_EVENT_CATEGORY] = cateogoryPF;   //get a new category

}

- (void)setNewObject:(UserEntity *)object withRemoteObject:(RemoteObject *)remoteObj inManagedObjectContext:(NSManagedObjectContext *)context {
    [super setNewObject:object withRemoteObject:remoteObj inManagedObjectContext:context];
    NSAssert([object isKindOfClass:[Event class]], @"Type casting is wrong");
    Event * event = (Event *)object;
    
    event.alert = [Alert createEntity:context];
    [[AlertRemoteUtil sharedUtil] setNewObject:event.alert withRemoteObject:remoteObj[PF_EVENT_ALERT] inManagedObjectContext:context];
    
    PFObject * placePF = remoteObj[PF_EVENT_PLACE];
    event.place = [Place createEntity:context];
    [[PlaceRemoteUtil]]
}

- (void)setExistedObject:(UserEntity *)object withRemoteObject:(RemoteObject *)remoteObj inManagedObjectContext:(NSManagedObjectContext *)context {
    [super setExistedObject:object withRemoteObject:remoteObj inManagedObjectContext:context];
    NSAssert([object isKindOfClass:[Event class]], @"Type casting is wrong");
    Event * event = (Event *)object;
    
    [[AlertRemoteUtil sharedUtil] setExistedObject:event.alert withRemoteObject:remoteObj[PF_EVENT_ALERT] inManagedObjectContext:context];
}

- (void) setEvent:(Event *)event withRemoteObject:(RemoteObject *)object inManagedObjectContext: (NSManagedObjectContext *)context{
    event.globalID = object[PF_EVENT_OBJECTID];
    

    
    // Place should have been fetched
    // this cannot use the pattern for alert
    // because place is a system entity, it may have existed in our data storage but we cannot create another same one
    PFObject * placePF = object[PF_EVENT_PLACE];
    event.place = [Place entityWithID:placePF.objectId   inManagedObjectContext:context];
    
    
    User * user = [User convertFromRemoteUser:object[PF_EVENT_CREATE_USER] inManagedObjectContext:context];
    event.user = user;
    
    event.category = nil;   //get a new category
    
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
