//
//  RecentLocalDataUtility.m
//  MyApp
//
//  Created by Linwei Ding on 11/8/15.
//  Copyright © 2015 Linweiding. All rights reserved.
//
#import "Recent+Util.h"
#import "UserRemoteUtil.h"
#import "User+Util.h"
#import "RecentLocalDataUtil.h"

#undef LOCAL_DATA_CLASS_TYPE
#define LOCAL_DATA_CLASS_TYPE Recent

@implementation RecentLocalDataUtil

+ (RecentLocalDataUtil *)sharedUtil {
    static dispatch_once_t predicate = 0;
    static RecentLocalDataUtil *sharedObject;
    
    dispatch_once(&predicate, ^{
        //initializing singleton object
        sharedObject = [[self alloc] init];
        
        sharedObject.className = PF_RECENT_CLASS_NAME;
        
        sharedObject.index = LOCAL_DATA_RECENT_INDEX;
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
    
    
    LOCAL_DATA_CLASS_TYPE * recent = (LOCAL_DATA_CLASS_TYPE *)object;
    
    recent.chatID = dict[PF_RECENT_GROUPID];
    recent.members = [NSArray arrayWithArray:dict[PF_RECENT_MEMBERS]] ;
    recent.details = dict[PF_RECENT_DESCRIPTION] ;
    recent.lastUser = [[UserRemoteUtil sharedUtil] convertToUser:dict[PF_RECENT_LASTUSER]];
    recent.lastMessage = dict[PF_RECENT_LASTMESSAGE] ;
    recent.counter = dict[PF_RECENT_COUNTER] ;
    
    recent.lastUser = [[UserRemoteUtil sharedUtil] convertToUser:dict[PF_RECENT_LASTUSER]];
}

@end
