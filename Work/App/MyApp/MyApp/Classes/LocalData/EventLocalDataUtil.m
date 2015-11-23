//
//  EventLocalUtility.m
//  MyApp
//
//  Created by Linwei Ding on 11/7/15.
//  Copyright © 2015 Linweiding. All rights reserved.
//

#import "AppHeader.h"
#import "Event+Util.h"
#import "Alert+Util.h"
#import "EventCategory+Util.h"
#import "Place+Util.h"
#import "User+Util.h"
#import "EventLocalDataUtil.h"

#undef LOCAL_DATA_CLASS_TYPE
#define LOCAL_DATA_CLASS_TYPE Event



@implementation EventLocalDataUtil

+ (EventLocalDataUtil *)sharedUtil {
    static dispatch_once_t predicate = 0;
    static EventLocalDataUtil *sharedObject;
    
    dispatch_once(&predicate, ^{
        //initializing singleton object
        sharedObject = [[self alloc] init];
        
        sharedObject.className = PF_EVENT_CLASS_NAME;
        
        sharedObject.index = LOCAL_DATA_EVENT_INDEX;
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
    
    //event.startTime  = dict[PF_EVENT_START_TIME] ;
    
    [event setStartTimeGroup:dict[PF_EVENT_START_TIME]];
    
    event.endTime  = dict[PF_EVENT_END_TIME] ;
    event.invitees = dict[PF_EVENT_INVITEES] ;
    event.isAlert = dict[PF_EVENT_IS_ALERT];
    event.location  = dict[PF_EVENT_LOCATION];
    event.notes  = dict[PF_EVENT_NOTES] ;
    event.title = dict[PF_EVENT_TITLE] ;
    event.scope  = dict[PF_EVENT_SCOPE] ;
    event.boardIDs  = dict[PF_EVENT_BOARD_IDS] ;    //array
    event.votingID  = dict[PF_EVENT_VOTING_ID] ;
    event.members  = dict[PF_EVENT_MEMBERS] ;
    event.groupIDs  = dict[PF_EVENT_GROUP_IDS] ;
    event.isVoting  = dict[PF_EVENT_IS_VOTING] ;
    
    event.alert = [Alert entityWithID:dict[PF_EVENT_ALERT] inManagedObjectContext:self.managedObjectContext];
    event.category = [EventCategory entityWithID:dict[PF_EVENT_CATEGORY] inManagedObjectContext:self.managedObjectContext];
    event.place = [Place entityWithID:dict[PF_EVENT_PLACE] inManagedObjectContext:self.managedObjectContext];
}

// delete the user in the event
- (void) removeLocalEventMember:(Event *)event user:(User *)user completionHandler:(REMOTE_BOOL_BLOCK)block {
    
    if ([event.members containsObject: user.globalID]) {
        if ([event.members count] == 1) {
            // only the user is left, delete the remote object
            [self.managedObjectContext deleteObject:event];
            //[object deleteInBackgroundWithBlock:block];
        }
        else {
            // other users are left, just remove the member of the user
            [event.members removeObject:user.globalID];
        }
    }
}


//- (NSDateFormatter *)dateFormatter
//{
//    static NSDateFormatter *dateFormatter;
//    if(!dateFormatter){
//        dateFormatter = [NSDateFormatter new];
//        dateFormatter.dateFormat = @"dd-MM-yyyy";
//    }
//    
//    return dateFormatter;
//}
//
//- (BOOL)haveEventForDay:(NSDate *)date
//{
//    NSString *key = [[self dateFormatter] stringFromDate:date];
//    
//    if(_eventsByDate[key] && [_eventsByDate[key] count] > 0){
//        return YES;
//    }
//    
//    return NO;
//    
//}
//
//- (void)createRandomEvents
//{
//    _eventsByDate = [NSMutableDictionary new];
//    
//    for(int i = 0; i < 30; ++i){
//        // Generate 30 random dates between now and 60 days later
//        NSDate *randomDate = [NSDate dateWithTimeInterval:(rand() % (3600 * 24 * 60)) sinceDate:[NSDate date]];
//        
//        // Use the date as key for eventsByDate
//        NSString *key = [[self dateFormatter] stringFromDate:randomDate];
//        
//        Event * event = [Event createEntity:self.managedObjectContext];
//        event.boardIDs = @[];
//        event.endTime
//        
//        if(!_eventsByDate[key]){
//            _eventsByDate[key] = [NSMutableArray new];
//        }
//        
//        [_eventsByDate[key] addObject:randomDate];
//    }
//}


@end
