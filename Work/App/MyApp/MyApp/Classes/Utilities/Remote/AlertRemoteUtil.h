//
//  AlertRemoteUtil.h
//  MyApp
//
//  Created by Linwei Ding on 10/21/15.
//  Copyright (c) 2015 Linweiding. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Alert+Util.h"
#import "AppHeader.h"
#import "BaseRemoteUtil.h"


@interface AlertRemoteUtil : BaseRemoteUtil

+ (AlertRemoteUtil *)sharedUtil;

- (void) setCommonObject:(BASE_REMOTE_UTIL_OBJ_TYPE)object withRemoteObject:(RemoteObject *)remoteObj inManagedObjectContext: (NSManagedObjectContext *)context;

- (void) setCommonRemoteObject:(RemoteObject *)remoteObj withObject:(BASE_REMOTE_UTIL_OBJ_TYPE)object ;


@end
