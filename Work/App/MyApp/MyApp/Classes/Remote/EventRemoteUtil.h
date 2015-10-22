//
//  EventRemoteUtil.h
//  MyApp
//
//  Created by Linwei Ding on 10/19/15.
//  Copyright (c) 2015 AppsFoundation. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseRemoteUtil.h"

@interface EventRemoteUtil : BaseRemoteUtil 
+ (EventRemoteUtil *)sharedUtil;

- (void) setCommonObject:(BASE_REMOTE_UTIL_OBJ_TYPE)object withRemoteObject:(RemoteObject *)remoteObj inManagedObjectContext: (NSManagedObjectContext *)context;

- (void) setCommonRemoteObject:(RemoteObject *)remoteObj withAlert:(BASE_REMOTE_UTIL_OBJ_TYPE)object ;
@end
