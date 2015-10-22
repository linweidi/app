//
//  BaseRemoteUtil.m
//  MyApp
//
//  Created by Linwei Ding on 10/21/15.
//  Copyright © 2015 Linweiding. All rights reserved.
//
#import "AppHeader.h"
#import "UserEntity.h"
#import "BaseRemoteUtil.h"

#define BASE_REMOTE_UTIL_OBJ_TYPE UserEntity*
@implementation BaseRemoteUtil

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

// 1. create data model and populate
// 2. Create remote object and populate, and then save
// 3. after save, pass the objectId and time to data model
- (void) setNewRemoteObject:(RemoteObject *)remoteObj withObject:(BASE_REMOTE_UTIL_OBJ_TYPE)object{
    // these attributes should be updated after object model is created
    //remoteObj[PF_ALERT_CREATE_TIME] = object.createTime;
    //remoteObj[PF_ALERT_UPDATE_TIME] = object.updateTime;
    [self setCommonRemoteObject:remoteObj withObject:object];
}

// 1. update data model
// 2. create and populate remote object, set objectID and createTime
// 3. after save, populate updateTime to data model
- (void) setExistedRemoteObject:(RemoteObject *)remoteObj withObject:(BASE_REMOTE_UTIL_OBJ_TYPE)object{
    //remoteObj id should be used when the remote remoteObj is created
    // these attributes should be updated after object model is created
    remoteObj[PF_COMMON_OBJECTID] = object.objectID;
    remoteObj[PF_COMMON_CREATE_TIME] = object.createTime;
    //remoteObj[PF_ALERT_UPDATE_TIME] = object.updateTime;
    [self setCommonRemoteObject:remoteObj withObject:object];
}

- (RemoteObject *) createNewRemoteObject:(BASE_REMOTE_UTIL_OBJ_TYPE)object {
    PFObject * remoteObj = [PFObject objectWithClassName:PF_ALERT_CLASS_NAME];
    [self setNewRemoteObject:remoteObj withObject:object];
    
    return remoteObj;
}

- (RemoteObject *) createExistedRemoteObject:(BASE_REMOTE_UTIL_OBJ_TYPE)object {
    PFObject * remoteObj = [PFObject objectWithoutDataWithClassName:PF_ALERT_CLASS_NAME objectId:PF_COMMON_OBJECTID];
    [self setExistedRemoteObject:remoteObj withObject:object];
    return remoteObj;
}

#pragma mark -- private method

- (void) setCommonObject:(BASE_REMOTE_UTIL_OBJ_TYPE)object withRemoteObject:(RemoteObject *)remoteObj inManagedObjectContext:(NSManagedObjectContext *)context{
    
    NSAssert(NO, @"virtual function");
}

- (void) setCommonRemoteObject:(RemoteObject *)remoteObj withObject:(BASE_REMOTE_UTIL_OBJ_TYPE)object {
    NSAssert(NO, @"virtual function");
}
@end
