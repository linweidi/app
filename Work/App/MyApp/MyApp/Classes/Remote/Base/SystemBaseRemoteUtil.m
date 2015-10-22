//
//  SystemBaseRemoteUtil.m
//  MyApp
//
//  Created by Linwei Ding on 10/21/15.
//  Copyright © 2015 Linweiding. All rights reserved.
//


#import "SystemBaseRemoteUtil.h"

#define BASE_REMOTE_UTIL_OBJ_TYPE SystemEntity*

@implementation SystemBaseRemoteUtil

// 1. download this remote object
// 2. after download, create this data model and populate
- (void) setNewObject:(BASE_REMOTE_UTIL_OBJ_TYPE)object withRemoteObject:(RemoteObject *)remoteObj inManagedObjectContext: (NSManagedObjectContext *)context {
    object.globalID = remoteObj[PF_COMMON_OBJECTID];
    object.createTime = remoteObj[PF_COMMON_CREATE_TIME];
    object.updateTime = remoteObj[PF_COMMON_UPDATE_TIME];
    [self setCommonObject:object withRemoteObject:remoteObj inManagedObjectContext:context];
}

// 1. download remote object
// 2. populate all data model attributes
- (void) setExistedObject:(BASE_REMOTE_UTIL_OBJ_TYPE)object withRemoteObject:(RemoteObject *)remoteObj inManagedObjectContext: (NSManagedObjectContext *)context {
    // these attributes are not necessary to update
    //object.globalID = remoteObj[PF_ALERT_OBJECTID];
    //object.createTime = remoteObj[PF_ALERT_CREATE_TIME];
    object.updateTime = remoteObj[PF_COMMON_UPDATE_TIME];
    
    [self setCommonObject:object withRemoteObject:remoteObj inManagedObjectContext:context];
}


- (void) setCommonObject:(BASE_REMOTE_UTIL_OBJ_TYPE)object withRemoteObject:(RemoteObject *)remoteObj inManagedObjectContext:(NSManagedObjectContext *)context{
    
    NSAssert(NO, @"virtual function");
}

@end
