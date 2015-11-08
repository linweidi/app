//
//  BaseRemoteUtil.h
//  MyApp
//
//  Created by Linwei Ding on 10/21/15.
//  Copyright © 2015 Linweiding. All rights reserved.
//

#import "AppHeader.h"
#import <Foundation/Foundation.h>




#define BASE_REMOTE_UTIL_OBJ_TYPE ObjectEntity*

@class ObjectEntity;

//DOWNLOAD
//NOTE: for download, we should fetch the remote object firstly, and then process data model
//UPLOAD
//NOTE: for upload, we should create or update data model firstly, and then upload remote object. For create, then we get objectID and createTime and updateTime. For update, then we get updateTime
//NOTE: the local data storage is subset of remote storage, that means if one object is not in local, it may exist remotely. If not exist remotely, it is never stored locally

@interface BaseRemoteUtil : NSObject

// 1. download this remote object
// 2. after download, create this data model and populate
// X1. save remote object
// X2. after save, create a data model and populate
// because we have created data model at first
- (void) setNewObject:(BASE_REMOTE_UTIL_OBJ_TYPE)object withRemoteObject:(RemoteObject *)remoteObj inManagedObjectContext: (NSManagedObjectContext *)context;

// 1. download remote object
// 2. populate all data model attributes
// X1. download remote object
// X2. update remote object, and save
// X3. update data model
// because we should not update remote object directly
- (void) setExistedObject:(BASE_REMOTE_UTIL_OBJ_TYPE)object withRemoteObject:(RemoteObject *)remoteObj inManagedObjectContext: (NSManagedObjectContext *)context;

// 1. create data model and populate
// 2. Create remote object and populate, and then save
// 3. after save, pass the objectId and time to data model
// Note: object can be data model or core data model,
//      if data model, we need create another core data model after complete
//      if core data model, we need delete this after fail
// @param[IN]: we assume the argument object is data model, not core data model
- (void) setNewRemoteObject:(RemoteObject *)remoteObj withObject:(BASE_REMOTE_UTIL_OBJ_TYPE)object;

// 1. update data model
// 2. populate remote object
// 3. after save, populate updateTime to data model
- (void) setExistedRemoteObject:(RemoteObject *)remoteObj withObject:(BASE_REMOTE_UTIL_OBJ_TYPE)object;



#pragma mark -- networking functions
#pragma mark -- upload object
// @param[IN]: we assume the argument object is data model, not core data model
- (void) uploadCreateRemoteObject:(BASE_REMOTE_UTIL_OBJ_TYPE)object  completionHandler:(REMOTE_OBJECT_BLOCK)block;

- (void) uploadCreateRemoteObject:(BASE_REMOTE_UTIL_OBJ_TYPE)object localSyncs:(BOOL)localSync completionHandler:(REMOTE_OBJECT_BLOCK)block;

// @param[IN]: we assume the argument object is core data model, not data model
- (void) uploadUpdateRemoteObject:(BASE_REMOTE_UTIL_OBJ_TYPE)object updateAttrs:(NSArray *)updateAttrs completionHandler:(REMOTE_OBJECT_BLOCK)block;

// @param[IN] remoteObj: this remote object is created and popualted externally. If remote object has been update, we can just pass nil to modifiedObject
- (void) uploadUpdateRemoteObject:(RemoteObject *)remoteObj modifyObject:(BASE_REMOTE_UTIL_OBJ_TYPE)object completionHandler:(REMOTE_OBJECT_BLOCK)block;

- (void) uploadRemoveRemoteObject:(BASE_REMOTE_UTIL_OBJ_TYPE)object completionHandler:(REMOTE_BOOL_BLOCK)block;

#pragma mark -- download one object
- (void) downloadCreateObject:(NSString *)globalID completionHandler:(REMOTE_BOTH_OBJECT_BLOCK)block;

- (void) downloadCreateObject:(NSString *)globalID includeKeys:(NSArray *)keys completionHandler:(REMOTE_BOTH_OBJECT_BLOCK)block;

- (void) downloadUpdateObject:(BASE_REMOTE_UTIL_OBJ_TYPE)entity completionHandler:(REMOTE_BOTH_OBJECT_BLOCK)block;
    
- (void) downloadUpdateObject:(BASE_REMOTE_UTIL_OBJ_TYPE)entity includeKeys:(NSArray *)keys  completionHandler:(REMOTE_BOTH_OBJECT_BLOCK)block;

#pragma mark -- download many objects
- (void) downloadCreateObjectsWithQuery:(PFQuery *)query completionHandler:(REMOTE_BOTH_ARRAY_BLOCK)block;

- (void) downloadObjectsWithQuery:(PFQuery *)query completionHandler:(REMOTE_BOTH_ARRAY_BLOCK)block;

- (void) downloadCreateObjectsWithLatest:(BASE_REMOTE_UTIL_OBJ_TYPE)latest includeKeys:(NSArray *)keys orders:(NSArray *)orders completionHandler:(REMOTE_BOTH_ARRAY_BLOCK)block;

- (void) downloadCreateObjectsWithLatest:(BASE_REMOTE_UTIL_OBJ_TYPE)latest includeKeys:(NSArray *)keys orders:(NSArray *)orders updateQueryHandler:(REMOTE_OBJECT_BLOCK)queryHandler completionHandler:(REMOTE_BOTH_ARRAY_BLOCK)block;
//- (void) downloadAllObjects:(RemoteObject *)remoteObj includeKeys:(NSArray *)keys completionHandler:(REMOTE_ARRAY_BLOCK)block;



#pragma mark -- private method

- (RemoteObject *) createAndPopulateNewRemoteObject:(BASE_REMOTE_UTIL_OBJ_TYPE)object;

- (RemoteObject *) createAndPopulateExistedRemoteObject:(BASE_REMOTE_UTIL_OBJ_TYPE)object;

- (void) setCommonObject:(BASE_REMOTE_UTIL_OBJ_TYPE)object withRemoteObject:(RemoteObject *)remoteObj inManagedObjectContext: (NSManagedObjectContext *)context;

- (void) setCommonRemoteObject:(RemoteObject *)remoteObj withObject:(BASE_REMOTE_UTIL_OBJ_TYPE)object;

@property (strong, nonatomic) NSString * className;

@property (strong, nonatomic) NSManagedObjectContext * managedObjectContext;

@end
