//
//  EventCategoryRemoteUtil.h
//  MyApp
//
//  Created by Linwei Ding on 11/14/15.
//  Copyright © 2015 Linweiding. All rights reserved.
//

#import "SystemBaseRemoteUtil.h"

#undef BASE_REMOTE_UTIL_OBJ_TYPE
#define BASE_REMOTE_UTIL_OBJ_TYPE ObjectEntity*

@interface EventCategoryRemoteUtil : SystemBaseRemoteUtil

+ (EventCategoryRemoteUtil *)sharedUtil;
//
//- (void) setCommonObject:(BASE_REMOTE_UTIL_OBJ_TYPE)object withRemoteObject:(RemoteObject *)remoteObj inManagedObjectContext: (NSManagedObjectContext *)context;
//
//- (void) setCommonRemoteObject:(RemoteObject *)remoteObj withAlert:(BASE_REMOTE_UTIL_OBJ_TYPE)object;
//
//- (void)setExistedObject:(BASE_REMOTE_UTIL_OBJ_TYPE)object withRemoteObject:(RemoteObject *)remoteObj inManagedObjectContext:(NSManagedObjectContext *)context ;
//
//- (void)setNewObject:(BASE_REMOTE_UTIL_OBJ_TYPE)object withRemoteObject:(RemoteObject *)remoteObj inManagedObjectContext:(NSManagedObjectContext *)context ;
//
////- (void)setExistedRemoteObject:(RemoteObject *)remoteObj withObject:(SystemEntity *)object;
//
//- (void)setNewRemoteObject:(RemoteObject *)remoteObj withObject:(BASE_REMOTE_UTIL_OBJ_TYPE)object;

@end
