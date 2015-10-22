//
//  BaseRemoteUtil.h
//  MyApp
//
//  Created by Linwei Ding on 10/21/15.
//  Copyright © 2015 Linweiding. All rights reserved.
//

#import "AppHeader.h"
#import <Foundation/Foundation.h>

#define BASE_REMOTE_UTIL_OBJ_TYPE UserEntity*

@interface BaseRemoteUtil : NSObject

// 1. download this remote object
// 2. after download, create this data model and populate
- (void) setNewObject:(BASE_REMOTE_UTIL_OBJ_TYPE)object withRemoteObject:(RemoteObject *)remoteObj inManagedObjectContext: (NSManagedObjectContext *)context;

// 1. download remote object
// 2. populate all data model attributes
- (void) setExistedObject:(BASE_REMOTE_UTIL_OBJ_TYPE)object withRemoteObject:(RemoteObject *)remoteObj inManagedObjectContext: (NSManagedObjectContext *)context;

// 1. create data model and populate
// 2. Create remote object and populate, and then save
// 3. after save, pass the objectId and time to data model
- (void) setNewRemoteObject:(RemoteObject *)remoteObj withObject:(BASE_REMOTE_UTIL_OBJ_TYPE)object;

// 1. update data model
// 2. populate remote object
// 3. after save, populate updateTime to data model
- (void) setExistedRemoteObject:(RemoteObject *)remoteObj withObject:(BASE_REMOTE_UTIL_OBJ_TYPE)object;

- (RemoteObject *) createNewRemoteObject:(BASE_REMOTE_UTIL_OBJ_TYPE)object;


- (RemoteObject *) createExistedRemoteObject:(BASE_REMOTE_UTIL_OBJ_TYPE)object;

- (void) setCommonObject:(BASE_REMOTE_UTIL_OBJ_TYPE)object withRemoteObject:(RemoteObject *)remoteObj inManagedObjectContext: (NSManagedObjectContext *)context;

- (void) setCommonRemoteObject:(RemoteObject *)remoteObj withObject:(BASE_REMOTE_UTIL_OBJ_TYPE)object;

@property (strong, nonatomic) NSString * className;

@end
