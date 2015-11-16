//
//  GroupLocalDataUtility.h
//  MyApp
//
//  Created by Linwei Ding on 11/8/15.
//  Copyright © 2015 Linweiding. All rights reserved.
//

#import "BaseLocalDataUtil.h"

@class Group;
@interface GroupLocalDataUtil : BaseLocalDataUtil

+ (GroupLocalDataUtil *)sharedUtil;

- (void) setRandomValues: (id) object data:(NSDictionary *)dict;

- (NSArray *)constructDataFromDict:(NSDictionary *)dict;

- (void) createLocalGroup:(NSString *)name members:(NSArray *)members completionHandler:(REMOTE_OBJECT_BLOCK)block;

- (void) removeLocalGroupMember:(Group *)group user:(User *)user completionHandler:(REMOTE_BOOL_BLOCK)block ;

- (void) removeLocalGroupMemberAll:(User *)createdUser user:(User *)user completionHandler:(REMOTE_BOOL_BLOCK)block;

- (void) removeLocalGroupItem:(Group *) group completionHandler:(REMOTE_BOOL_BLOCK)block ;

@end
