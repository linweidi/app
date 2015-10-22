//
//  SystemBaseRemoteUtil.h
//  MyApp
//
//  Created by Linwei Ding on 10/21/15.
//  Copyright © 2015 Linweiding. All rights reserved.
//

#import "AppHeader.h"
#import <Foundation/Foundation.h>
#import "SystemEntity.h"

#define BASE_REMOTE_UTIL_OBJ_TYPE SystemEntity*

@interface SystemBaseRemoteUtil : NSObject

// 1. download this remote object
// 2. after download, create this data model and populate
- (void) setNewObject:(BASE_REMOTE_UTIL_OBJ_TYPE)object withRemoteObject:(RemoteObject *)remoteObj inManagedObjectContext: (NSManagedObjectContext *)context;

// 1. download remote object
// 2. populate all data model attributes
- (void) setExistedObject:(BASE_REMOTE_UTIL_OBJ_TYPE)object withRemoteObject:(RemoteObject *)remoteObj inManagedObjectContext: (NSManagedObjectContext *)context;

- (void) setCommonObject:(BASE_REMOTE_UTIL_OBJ_TYPE)object withRemoteObject:(RemoteObject *)remoteObj inManagedObjectContext: (NSManagedObjectContext *)context;

@property (strong, nonatomic) NSString * className;

@end
