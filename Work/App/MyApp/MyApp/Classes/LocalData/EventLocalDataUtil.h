//
//  EventLocalUtility.h
//  MyApp
//
//  Created by Linwei Ding on 11/7/15.
//  Copyright © 2015 Linweiding. All rights reserved.
//

#import "BaseLocalDataUtil.h"

@class Event;
@interface EventLocalDataUtil : BaseLocalDataUtil

+ (EventLocalDataUtil *)sharedUtil;

- (void) setRandomValues: (id) object data:(NSDictionary *)dict;

- (NSArray *)constructDataFromDict:(NSDictionary *)dict;

- (void) removeLocalEventMember:(Event *)event user:(User *)user completionHandler:(REMOTE_BOOL_BLOCK)block;

@end
