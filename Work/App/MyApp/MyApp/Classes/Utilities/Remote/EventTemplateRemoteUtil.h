//
//  EventTemplateRemoteUtil.h
//  MyApp
//
//  Created by Linwei Ding on 11/20/15.
//  Copyright (c) 2015 Linweiding. All rights reserved.
//

#import "UserBaseRemoteUtil.h"

#undef BASE_REMOTE_UTIL_OBJ_TYPE
#define BASE_REMOTE_UTIL_OBJ_TYPE ObjectEntity*

@interface EventTemplateRemoteUtil : UserBaseRemoteUtil

+ (EventTemplateRemoteUtil *)sharedUtil;

- (void) setCommonObject:(BASE_REMOTE_UTIL_OBJ_TYPE)object withRemoteObject:(RemoteObject *)remoteObj inManagedObjectContext: (NSManagedObjectContext *)context;

- (void) setCommonRemoteObject:(RemoteObject *)remoteObj withObject:(BASE_REMOTE_UTIL_OBJ_TYPE)object;


@end
