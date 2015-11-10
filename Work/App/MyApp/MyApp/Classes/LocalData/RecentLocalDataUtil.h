//
//  RecentLocalDataUtility.h
//  MyApp
//
//  Created by Linwei Ding on 11/8/15.
//  Copyright © 2015 Linweiding. All rights reserved.
//

#import "BaseLocalDataUtil.h"

@interface RecentLocalDataUtil : BaseLocalDataUtil

+ (RecentLocalDataUtil *)sharedUtil;

- (void) setRandomValues: (id) object data:(NSDictionary *)dict;

- (NSArray *)constructDataFromDict:(NSDictionary *)dict;

- (NSString *) startLocalPrivateChat:(User *)user1 user2:(User *)user2;

- (NSString *) startLocalMultipleChat:(NSMutableArray *)users;

- (void) createLocalRecentItem:(User *)user  groupId:(NSString *)groupId members:(NSArray *)members desciption:(NSString *)description lastMessage:(NSString *)lastMessage;

- (void) updateLocalRecentAndCounter:(NSString *)groupId amount:(NSInteger)amount lastMessage:(NSString *)lastMessage members:(NSArray *)members;

- (void) clearLocalRecentCounter:(NSString *)groupId;
@end
