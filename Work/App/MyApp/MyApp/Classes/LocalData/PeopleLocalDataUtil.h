//
//  PeopleLocalDataUtility.h
//  MyApp
//
//  Created by Linwei Ding on 11/8/15.
//  Copyright © 2015 Linweiding. All rights reserved.
//

#import "BaseLocalDataUtil.h"

@class User;

@interface PeopleLocalDataUtil : BaseLocalDataUtil

+ (PeopleLocalDataUtil *)sharedUtil;

- (void) setRandomValues: (id) object data:(NSDictionary *)dict;

- (NSArray *)constructDataFromDict:(NSDictionary *)dict;

- (void) createLocalPeople:(NSString *)name user:(User *)user2 completionHandler:(REMOTE_OBJECT_BLOCK)block;

- (void) removeLocalPeople:(User *)user2  completionHandler:(REMOTE_BOOL_BLOCK)block;
@end
