//
//  BaseRemoteUtil.m
//  MyApp
//
//  Created by Linwei Ding on 10/21/15.
//  Copyright © 2015 Linweiding. All rights reserved.
//
#import "AppHeader.h"
#import "SystemEntity.h"
#import "SystemBaseRemoteUtil.h"


@implementation SystemBaseRemoteUtil
//NOTE: for download, we should fetch the remote object firstly, and then process data model
// NOTE: for upload, we should create or update data model firstly, and then upload remote object. For create, then we get objectID and createTime and updateTime. For update, then we get updateTime


// 1. download this remote object
// 2. after download, create this data model and populate
// X1. save remote object
// X2. after save, create a data model and populate
// because we have created data model at first
- (void) setNewObject:(BASE_REMOTE_UTIL_OBJ_TYPE)object withRemoteObject:(RemoteObject *)remoteObj inManagedObjectContext: (NSManagedObjectContext *)context {
    object.globalID = remoteObj.objectId;
    object.createTime = remoteObj.createdAt;
    object.updateTime = remoteObj.updatedAt;
    [self setCommonObject:object withRemoteObject:remoteObj inManagedObjectContext:context];
}

// 1. download remote object
// 2. populate all data model attributes
// X1. download remote object
// X2. update remote object, and save
// X3. update data model
// because we should not update remote object directly
- (void) setExistedObject:(BASE_REMOTE_UTIL_OBJ_TYPE)object withRemoteObject:(RemoteObject *)remoteObj inManagedObjectContext: (NSManagedObjectContext *)context {
    // these attributes are not necessary to update
    // here, only updatedAt is returned for update upload
    object.globalID = remoteObj.objectId;
    // createdAt is not downloaded here
    //object.createTime = remoteObj.createdAt;
    object.updateTime = remoteObj.updatedAt;
    
    [self setCommonObject:object withRemoteObject:remoteObj inManagedObjectContext:context];
}

// 1. create a temporary data model and populate
// 2. Create remote object and populate, and then save
// 3. after save, create a data model and pass the objectId and time to data model
// Note: object can be data model or core data model
- (void) setNewRemoteObject:(RemoteObject *)remoteObj withObject:(BASE_REMOTE_UTIL_OBJ_TYPE)object{
    // these attributes should be updated after object model is created
    remoteObj.objectId = object.globalID;
    //remoteObj[PF_ALERT_CREATE_TIME] = object.createTime;
    //remoteObj[PF_ALERT_UPDATE_TIME] = object.updateTime;
    [self setCommonRemoteObject:remoteObj withObject:object];
}

// 1. provide update attribute dictionary
// 2. create and populate remote object, set objectID
// 3. after save, populate updateTime to data model, update data model
- (void) setExistedRemoteObject:(RemoteObject *)remoteObj withObject:(BASE_REMOTE_UTIL_OBJ_TYPE)object {
    //remoteObj id should be used when the remote remoteObj is created
    // these attributes should be updated after object model is created
    remoteObj.objectId = object.globalID;
    //remoteObj[PF_COMMON_CREATE_TIME] = object.createTime;
    //remoteObj[PF_ALERT_UPDATE_TIME] = object.updateTime;
    [self setCommonRemoteObject:remoteObj withObject:object];
}

//// Modify remoteObj externally
//- (void) setExistedRemoteObject:(RemoteObject *)remoteObj withGlobalID:(NSString *)globalID {
//    //remoteObj id should be used when the remote remoteObj is created
//    // these attributes should be updated after object model is created
//    remoteObj.objectId = globalID;
//    //remoteObj[PF_COMMON_CREATE_TIME] = object.createTime;
//    //remoteObj[PF_ALERT_UPDATE_TIME] = object.updateTime;
//    //[self setCommonRemoteObject:remoteObj withObject:object];
//}

#pragma mark -- networking functions

// @param[IN]: we assume the argument object is data model, not core data model
- (void) uploadCreateRemoteObject:(BASE_REMOTE_UTIL_OBJ_TYPE)object inManagedObjectContext:(NSManagedObjectContext *)context completionHandler:(REMOTE_OBJECT_BLOCK)block {
    RemoteObject * remoteObj = [self createAndPopulateNewRemoteObject:object];
    [remoteObj saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        if (succeeded) {
            // create a new core data entity object
            BASE_REMOTE_UTIL_OBJ_TYPE newObject = [NSEntityDescription insertNewObjectForEntityForName:self.className inManagedObjectContext:context];
            [self setNewObject:newObject withRemoteObject:remoteObj inManagedObjectContext:context];
            // not necessary, already set in setNewObject:
            //newObject.globalID = remoteObj.objectId;
            //newObject.createTime = remoteObj.createdAt;
            //newObject.updateTime = remoteObj.updatedAt;
            block(newObject, error);
        }
        else {
            
            [ProgressHUD showError:@"Network Error."];
        }
    }];
}

// @param[IN]: we assume the argument object is core data model, not data model
- (void) uploadUpdateRemoteObject:(BASE_REMOTE_UTIL_OBJ_TYPE)object updateAttrs:(NSDictionary *)updateAttrs completionHandler:(REMOTE_OBJECT_BLOCK)block {
    RemoteObject * remoteObj = [PFObject objectWithoutDataWithClassName:self.className objectId:object.globalID];
    
    [self setRemoteObject:remoteObj updateAttrs:updateAttrs];
    
    [remoteObj saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        
        if (succeeded) {
            //No need to set all attribute, even it is wrong, remoteObj does not has all attributes
            //[self setExistedObject:object withRemoteObject:remoteObj inManagedObjectContext:object.managedObjectContext];
            // already set in setExistedObject:
            //object.updateTime = remoteObj.updatedAt;
            [self setObject:object updateAttrs:updateAttrs];
            object.updateTime = remoteObj.updatedAt;
            block(object, error);
        }
        else {
            [ProgressHUD showError:@"Network Error."];
        }
    }];
}

//- (void) uploadUpdateRemoteObject:(BASE_REMOTE_UTIL_OBJ_TYPE)object inManagedObjectContext:(NSManagedObjectContext *)context completionHandler:(REMOTE_OBJECT_BLOCK)block {
//    RemoteObject * remoteObj = [self createAndPopulateNewRemoteObject:object];
//    [remoteObj saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
//        if (succeeded) {
//            // create a new core data entity object
//            BASE_REMOTE_UTIL_OBJ_TYPE newObject = [NSEntityDescription insertNewObjectForEntityForName:self.className inManagedObjectContext:context];
//            [self setExistedObject:newObject withRemoteObject:remoteObj inManagedObjectContext:context];
//            // not necessary, already set in setNewObject:
//            //newObject.globalID = remoteObj.objectId;
//            //newObject.createTime = remoteObj.createdAt;
//            //newObject.updateTime = remoteObj.updatedAt;
//            block(newObject, error);
//        }
//        else {
//
//            [ProgressHUD showError:@"Network Error."];
//        }
//    }];
//}

// @param[IN] remoteObj: this remote object is created and popualted externally. If remote object has been update, we can just pass nil to modifiedObject
//- (void) uploadUpdateRemoteObject:(RemoteObject *)remoteObj modifiedObject:(BASE_REMOTE_UTIL_OBJ_TYPE)object updateAttrs:(NSDictionary *)updateAttrs completionHandler:(REMOTE_OBJECT_BLOCK)block {
//    //RemoteObject * remoteObj = [self createAndPopulateExistedRemoteObject:object];
//
//    [self setRemoteObject:remoteObj updateAttrs:updateAttrs];
//
//    [remoteObj saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
//
//        if (succeeded) {
//            //No need to set all attribute, even it is wrong, remoteObj does not has all attributes
//            //[self setExistedObject:object withRemoteObject:remoteObj inManagedObjectContext:object.managedObjectContext];
//            object.updateTime = remoteObj.updatedAt;
//            [self setObject:object updateAttrs:updateAttrs];
//            block(object, error);
//        }
//        else {
//            [ProgressHUD showError:@"Network Error."];
//        }
//    }];
//}

- (void) uploadUpdateRemoteObject:(RemoteObject *)remoteObj modifiedObject:(BASE_REMOTE_UTIL_OBJ_TYPE)object completionHandler:(REMOTE_OBJECT_BLOCK)block {
    
    [remoteObj saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        if (succeeded) {
            object.updateTime = remoteObj.updatedAt;
            block(object, error);
        }
        else {
            [ProgressHUD showError:@"Network Error."];
        }
    }];
}

// note: remember to update the updateTime
//- (void) uploadUpdateRemoteObject:(NSString *)globalID updateAttrHandler:(REMOTE_RT_OBJECT_BLOCK)updateBlock completionHandler:(REMOTE_RT_OBJECT_BLOCK)block {
//    PFObject * remoteObj = [PFObject objectWithoutDataWithClassName:self.className objectId:globalID];
//    //[self setExistedRemoteObject:remoteObj withObject:object];
//
//    updateBlock(remoteObj, nil);
//
//    [remoteObj saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
//        //object.globalID = remoteObj.objectId;
//        //object.createTime = remoteObj.createdAt;
//        if (succeeded) {
//            //object.updateTime = remoteObj.updatedAt;
//            block(remoteObj, error);
//        }
//        else {
//            [ProgressHUD showError:@"Network Error."];
//        }
//    }];
//}

- (void) uploadRemoveRemoteObject:(BASE_REMOTE_UTIL_OBJ_TYPE)object completionHandler:(REMOTE_BOOL_BLOCK)block {
    RemoteObject * remoteObj = [PFObject objectWithoutDataWithClassName:self.className objectId:object.globalID];
    [remoteObj deleteInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        if (succeeded) {
            [object.managedObjectContext deleteObject:object];
            block(succeeded, error);
        }
        else {
            [ProgressHUD showError:@"Network Error."];
        }
    }];
}

- (void) downloadCreateObject:(NSString *)globalID inManagedObjectContext:(NSManagedObjectContext *)context completionHandler:(REMOTE_OBJECT_BLOCK)block {
    [self downloadCreateObject:globalID includeKeys:nil inManagedObjectContext:context completionHandler:block];
    
}

- (void) downloadCreateObject:(NSString *)globalID includeKeys:(NSArray *)keys inManagedObjectContext:(NSManagedObjectContext *)context completionHandler:(REMOTE_OBJECT_BLOCK)block {
    PFQuery *query = [PFQuery queryWithClassName:self.className];
    
    for (NSString * key in keys) {
        [query includeKey:key];
    }
    
    [query getObjectInBackgroundWithId:globalID block:^(PFObject *remoteObj, NSError *error) {
        if (!error) {
            BASE_REMOTE_UTIL_OBJ_TYPE object = [NSEntityDescription insertNewObjectForEntityForName:self.className inManagedObjectContext:context ];
            
            [self setNewObject:object withRemoteObject:remoteObj inManagedObjectContext:context];
            
            block(object, error);
        }
        else {
            [ProgressHUD showError:@"Network Error."];
        }
    }];
}

- (void) downloadUpdateObject:(BASE_REMOTE_UTIL_OBJ_TYPE)entity completionHandler:(REMOTE_OBJECT_BLOCK)block {
    [self downloadUpdateObject:entity includeKeys:nil completionHandler:block];
}


- (void) downloadUpdateObject:(BASE_REMOTE_UTIL_OBJ_TYPE)entity includeKeys:(NSArray *)keys completionHandler:(REMOTE_OBJECT_BLOCK)block {
    PFQuery *query = [PFQuery queryWithClassName:self.className];
    for (NSString * key in keys) {
        [query includeKey:key];
    }
    
    [query getObjectInBackgroundWithId:entity.globalID block:^(PFObject *remoteObj, NSError *error) {
        if (!error) {
            
            if ([entity.updateTime compare: remoteObj.updatedAt] != NSOrderedSame) {
                [self setExistedObject:entity withRemoteObject:remoteObj inManagedObjectContext:entity.managedObjectContext];
            }
            
            block(entity, error);
        }
        else {
            [ProgressHUD showError:@"Network Error."];
        }
    }];
}

- (void) downloadCreateObjectsWithLatest:(BASE_REMOTE_UTIL_OBJ_TYPE)latest  includeKeys:(NSArray *)keys inManagedObjectContext:(NSManagedObjectContext *)context completionHandler:(REMOTE_ARRAY_BLOCK)block; {
    NSDate * latestUpdateDate = nil;
    
    // load from parse
    PFQuery *query = [PFQuery queryWithClassName:self.className];
    [query whereKey:PF_COMMON_USER equalTo:[PFUser currentUser]];
    if (keys) {
        for (NSString * key in keys) {
            [query includeKey:key];
        }
    }
    
    [query orderByDescending:PF_COMMON_UPDATE_TIME];
    
    if (latest) {
        //found any recent itme
        latestUpdateDate = latest.updateTime;
        [query whereKey:PF_COMMON_UPDATE_TIME greaterThan:latestUpdateDate];
    }
    else {
        // a new load
        
    }
    
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        if (!error) {
            NSMutableArray * array = [[NSMutableArray alloc] init];
            BASE_REMOTE_UTIL_OBJ_TYPE entity = nil;
            for (PFObject * objectRT in objects) {
                entity = [NSEntityDescription insertNewObjectForEntityForName:self.className inManagedObjectContext:context ];
                
                [self setNewObject:entity withRemoteObject:objectRT inManagedObjectContext:context];
                
                [array addObject:entity];
                block(array, error);
            }
        }
        else {
            [ProgressHUD showError:@"Network Error."];
        }
    }];
}

//- (void) downloadAllObjects:(RemoteObject *)remoteObj completionHandler:(REMOTE_ARRAY_BLOCK)block {
//
//}

- (void) setRemoteObject:(RemoteObject *)remoteObj updateAttrs:(NSArray *)updateAttrs {
    
    //@[@[ (NSArray)keys, object], @{@"value"}, @{ object}]
    RemoteObject * rmtObj = remoteObj;
    
    for (NSArray * actionItem in updateAttrs) {
        NSArray * keys = actionItem[0];
        id object = actionItem[1];
        
        NSUInteger keyCount = [keys count];
        int count = 0;
        for (NSString * key in keys) {
            if (keyCount == count + 1) {
                
                rmtObj[key] = object;
                
            }
            else {
                rmtObj = rmtObj[key];
            }
            count++;
        }
        
    }
}

- (void) setObject:(BASE_REMOTE_UTIL_OBJ_TYPE)object updateAttrs:(NSArray *)updateAttrs {
    BASE_REMOTE_UTIL_OBJ_TYPE obj = object;
    
    for (NSArray * actionItem in updateAttrs) {
        NSArray * keys = actionItem[0];
        id object = actionItem[1];
        
        NSUInteger keyCount = [keys count];
        int count = 0;
        for (NSString * key in keys) {
            if (keyCount == count + 1) {
                [obj setValue:object forKey:key];
                
            }
            else {
                obj = [obj valueForKey:key];
            }
            count++;
        }
        
    }
}


- (RemoteObject *) createAndPopulateNewRemoteObject:(BASE_REMOTE_UTIL_OBJ_TYPE)object {
    PFObject * remoteObj = [PFObject objectWithClassName:self.className];
    [self setNewRemoteObject:remoteObj withObject:object];
    
    return remoteObj;
}

- (RemoteObject *) createAndPopulateExistedRemoteObject:(BASE_REMOTE_UTIL_OBJ_TYPE)object {
    PFObject * remoteObj = [PFObject objectWithoutDataWithClassName:self.className objectId:object.globalID];
    //[self setExistedRemoteObject:remoteObj withObject:object];
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
