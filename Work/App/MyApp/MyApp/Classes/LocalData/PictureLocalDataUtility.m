//
//  PictureLocalDataUtility.m
//  MyApp
//
//  Created by Linwei Ding on 11/8/15.
//  Copyright © 2015 Linweiding. All rights reserved.
//
#import "Picture+Util.h"
#import "PictureLocalDataUtility.h"

#undef LOCAL_DATA_CLASS_TYPE
#define LOCAL_DATA_CLASS_TYPE Picture

@implementation PictureLocalDataUtility

+ (PictureLocalDataUtility *)sharedUtil {
    static dispatch_once_t predicate = 0;
    static PictureLocalDataUtility *sharedObject;
    
    dispatch_once(&predicate, ^{
        //initializing singleton object
        sharedObject = [[self alloc] init];
        
        sharedObject.className = PF_PICTURE_CLASS_NAME;
        
        sharedObject.index = LOCAL_DATA_PICTURE_INDEX;
    });
    return sharedObject;
}

#pragma mark - Inheritance methods

- (NSArray *)constructDataFromDict:(NSDictionary *)dict {
    
    NSMutableArray *resultArray = [NSMutableArray array];
    
    for (NSDictionary *obj in [dict allValues]) {
        
        LOCAL_DATA_CLASS_TYPE * object = [LOCAL_DATA_CLASS_TYPE createEntity:self.managedObjectContext];
        //Feedback *loadedData = [[Feedback alloc] init];
        
        [self setRandomValues:object data:obj];
        [resultArray addObject:object];
    }
    
    return [NSArray arrayWithArray:resultArray];
}

- (void) setRandomValues: (id) object data:(NSDictionary *)dict{
    [super setRandomValues:object data:dict];
    
    
    LOCAL_DATA_CLASS_TYPE * event = (LOCAL_DATA_CLASS_TYPE *)object;
    
    event.startTime  = dict[PF_EVENT_START_TIME] ;
    event.endTime  = dict[PF_EVENT_END_TIME] ;
    event.invitees = dict[PF_EVENT_INVITEES] ;
    event.isPicture = dict[PF_EVENT_IS_PICTURE];
    event.location  = dict[PF_EVENT_LOCATION];
    event.notes  = dict[PF_EVENT_NOTES] ;
    event.title = dict[PF_EVENT_TITLE] ;
    event.scope  = dict[PF_EVENT_SCOPE] ;
    event.boardIDs  = dict[PF_EVENT_BOARD_IDS] ;    //array
    event.votingID  = dict[PF_EVENT_VOTING_ID] ;
    event.members  = dict[PF_EVENT_MEMBERS] ;
    event.groupIDs  = dict[PF_EVENT_GROUP_IDS] ;
    event.isVoting  = dict[PF_EVENT_IS_VOTING] ;
    
    event.alert = [Picture entityWithID:dict[PF_EVENT_PICTURE] inManagedObjectContext:self.managedObjectContext];
    event.category = [EventCategory entityWithID:dict[PF_EVENT_CATEGORY] inManagedObjectContext:self.managedObjectContext];
    event.place = [Place entityWithID:dict[PF_EVENT_PLACE] inManagedObjectContext:self.managedObjectContext];
}

@end
