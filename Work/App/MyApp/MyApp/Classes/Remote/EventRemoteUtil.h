//
//  EventRemoteUtil.h
//  MyApp
//
//  Created by Linwei Ding on 10/19/15.
//  Copyright (c) 2015 AppsFoundation. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseRemoteUtil.h"



#define BASE_REMOTE_UTIL_OBJ_TYPE ObjectEntity*

@class UserEntity;
@interface EventRemoteUtil : BaseRemoteUtil



+ (EventRemoteUtil *)sharedUtil;

#pragma mark -- private functions
- (void) setCommonObject:(BASE_REMOTE_UTIL_OBJ_TYPE)object withRemoteObject:(RemoteObject *)remoteObj inManagedObjectContext: (NSManagedObjectContext *)context;

- (void) setCommonRemoteObject:(RemoteObject *)remoteObj withAlert:(BASE_REMOTE_UTIL_OBJ_TYPE)object ;

- (void)setNewRemoteObject:(RemoteObject *)remoteObj withObject:(UserEntity *)object ;

- (void)setExistedRemoteObject:(RemoteObject *)remoteObj withObject:(UserEntity *)object ;

- (void)setNewObject:(UserEntity *)object withRemoteObject:(RemoteObject *)remoteObj inManagedObjectContext:(NSManagedObjectContext *)context;

- (void)setExistedObject:(UserEntity *)object withRemoteObject:(RemoteObject *)remoteObj inManagedObjectContext:(NSManagedObjectContext *)context;

#pragma mark -- external functions
- (void) loadRemoteUsersByEvent:(Event *)event  completionHandler:(REMOTE_ARRAY_BLOCK)block;

- (void) loadRemoteEvents:(Event *)latestEvent completionHandler:(REMOTE_ARRAY_BLOCK)block ;

- (void) removeRemoteEventMember:(Event *)event user:(User *)user completionHandler:(REMOTE_BOOL_BLOCK)block ;

- (void) deleteRemoteEventItem:(Event *) event completionHandler:(REMOTE_BOOL_BLOCK)block ;

@end
