//
//  AlertRemoteUtil.m
//  MyApp
//
//  Created by Linwei Ding on 10/21/15.
//  Copyright (c) 2015 Linweiding. All rights reserved.
//

#import "AlertRemoteUtil.h"

@implementation AlertRemoteUtil


+ (AlertRemoteUtil *)sharedUtil {
    static dispatch_once_t predicate = 0;
    static AlertRemoteUtil *sharedObject;
    
    dispatch_once(&predicate, ^{
        //initializing singleton object
        sharedObject = [[self alloc] init];
        
        sharedObject.className = PF_ALERT_CLASS_NAME;
    });
    return sharedObject;
}

#pragma mark -- private method

- (void) setCommonObject:(BASE_REMOTE_UTIL_OBJ_TYPE)object withRemoteObject:(RemoteObject *)remoteObj inManagedObjectContext: (NSManagedObjectContext *)context{
    NSAssert([object isKindOfClass:[Alert class]], @"Type casting is wrong");
    Alert * alert = (Alert *)object;
    alert.time = remoteObj[PF_ALERT_TIME];
    alert.type = remoteObj[PF_ALERT_TYPE];
}

- (void) setCommonRemoteObject:(RemoteObject *)remoteObj withObject:(BASE_REMOTE_UTIL_OBJ_TYPE)object {
    NSAssert([object isKindOfClass:[Alert class]], @"Type casting is wrong");
    Alert * alert = (Alert *)object;
    remoteObj[PF_ALERT_TIME] = alert.time;
    remoteObj[PF_ALERT_TYPE] = alert.type;
}
@end
