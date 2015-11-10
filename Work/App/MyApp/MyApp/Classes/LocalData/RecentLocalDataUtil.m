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
#import "CurrentUser+Util.h"
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

- (NSString *) startLocalPrivateChat:(User *)user1 user2:(User *)user2 {
    NSString *id1 = user1.globalID;
    NSString *id2 = user2.globalID;
    //---------------------------------------------------------------------------------------------------------------------------------------------
    NSString *groupId = ([id1 compare:id2] < 0) ? [NSString stringWithFormat:@"%@%@", id1, id2] : [NSString stringWithFormat:@"%@%@", id2, id1];
    //---------------------------------------------------------------------------------------------------------------------------------------------
    NSArray *members = @[user1.globalID, user2.globalID];
    //---------------------------------------------------------------------------------------------------------------------------------------------
    //CreateRecentItem(user1, groupId, members, user2.fullname, context);
    //CreateRecentItem(user2, groupId, members, user1.fullname, context);
    [self createRecentItem:user1 groupId:groupId members:members desciption:user2.fullname lastMessage:nil];

    //---------------------------------------------------------------------------------------------------------------------------------------------
    return groupId;
}

- (NSString *) startLocalMultipleChat:(NSMutableArray *)users {
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
    

    [self createRecentItem:[[ConfigurationManager sharedManager] getCurrentUser] groupId:groupId members:userIds desciption:description lastMessage:nil];

    //---------------------------------------------------------------------------------------------------------------------------------------------
    return groupId;
}

- (void) createLocalRecentItem:(User *)user  groupId:(NSString *)groupId members:(NSArray *)members desciption:(NSString *)description lastMessage:(NSString *)lastMessage {
    
    NSFetchRequest * fetch = [NSFetchRequest fetchRequestWithEntityName:PF_RECENT_CLASS_NAME];
    fetch.predicate = [NSPredicate predicateWithFormat:@"chatID = %@", groupId];
    NSArray * match = [self.managedObjectContext executeFetchRequest:fetch error:nil];
    if ([match count]== 0) {
        //not found
        // create a new chat
        Recent * recent = nil;
        recent = [Recent createEntity:self.managedObjectContext];
        
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
        
        [super setCommonValues:recent];
    }
    else {
        NSLog(@"CreateRecentItem query error.");
        [ProgressHUD showError:@"CreateRecentItem error."];
    }
    

}

- (void) updateLocalRecentAndCounter:(NSString *)groupId amount:(NSInteger)amount lastMessage:(NSString *)lastMessage members:(NSArray *)members {
    NSFetchRequest * fetch = [NSFetchRequest fetchRequestWithEntityName:PF_RECENT_CLASS_NAME];
    fetch.predicate = [NSPredicate predicateWithFormat:@"chatID = %@", groupId];
    NSError * error;
    NSArray * match = [self.managedObjectContext executeFetchRequest:fetch error:&error];
    //[query setLimit:1000];
    
    if ([match count] == 1) {
        NSArray * objects = match;
        if (error == nil) {
            
            // for all the remote objects that are existent
            for (Recent *recent in objects) {
                
                recent.lastMessage = lastMessage;
                recent.lastUser = [[ConfigurationManager sharedManager] getCurrentUser];
                
                recent.updateTime = [NSDate date];
            }
        }
        else {
            NSLog(@"UpdateRecentCounter query error.");
        }
    }
    else {
        NSLog(@"updateRecentAndCounter query error.");
        [ProgressHUD showError:@"updateRecentAndCounter error."];
    }
    
}

- (void) clearLocalRecentCounter:(NSString *)groupId {
    NSFetchRequest * fetch = [NSFetchRequest fetchRequestWithEntityName:PF_RECENT_CLASS_NAME];
    fetch.predicate = [NSPredicate predicateWithFormat:@"chatID = %@", groupId];
    NSError * error;
    NSArray * match = [self.managedObjectContext executeFetchRequest:fetch error:&error];
    if ([match count] == 1) {
        if (error == nil) {
            Recent * recent = [match firstObject];
            recent.counter = @0;
        }
        else {
            NSLog(@"UpdateRecentCounter query error.");
        }
    }
    else {
        NSLog(@"clearRecentCounter query error.");
        [ProgressHUD showError:@"clearRecentCounter error."];
    }
}
@end
