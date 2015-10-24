//
//  ThumbnailRemoteUtil.h
//  MyApp
//
//  Created by Linwei Ding on 10/22/15.
//  Copyright © 2015 Linweiding. All rights reserved.
//

#import "BaseRemoteUtil.h"

@class Thumbnail;

@interface ThumbnailRemoteUtil : BaseRemoteUtil
+ (ThumbnailRemoteUtil *)sharedUtil;

//- (void) setCommonFile:(BASE_REMOTE_UTIL_OBJ_TYPE)object withRemoteFile:(RemoteFile *)remoteFile inManagedObjectContext: (NSManagedObjectContext *)context;
//
//- (void) setCommonRemoteFile:(RemoteFile *)remoteFile withObject:(BASE_REMOTE_UTIL_OBJ_TYPE)object ;

- (Thumbnail *) thumbnailEntityWithRemoteFile:(RemoteObject *)thumbFileRF withUserID:(NSString *)userID inManagedObjectContext: (NSManagedObjectContext *)context ;

//- (void)setExistedObject:(UserEntity *)object withRemoteObject:(RemoteObject *)remoteObj inManagedObjectContext:(NSManagedObjectContext *)context ;
//
//- (void)setNewObject:(UserEntity *)object withRemoteObject:(RemoteObject *)remoteObj inManagedObjectContext:(NSManagedObjectContext *)context ;

- (void)setNewRemoteObject:(RemoteObject *)remoteObj withObject:(UserEntity *)object;

- (void)setExistedRemoteObject:(RemoteObject *)remoteObj withObject:(UserEntity *)object;



- (void)setCommonRemoteObject:(RemoteObject *)remoteObj withObject:(UserEntity *)object;

- (void)setCommonObject:(UserEntity *)object withRemoteObject:(RemoteObject *)remoteObj inManagedObjectContext:(NSManagedObjectContext *)context;

@end
