//
//  VideoRemoteUtil.h
//  MyApp
//
//  Created by Linwei Ding on 10/31/15.
//  Copyright © 2015 Linweiding. All rights reserved.
//

#import "AppHeader.h"
#import "BaseRemoteUtil.h"

@class UserEntity;
@class Video;
@interface VideoRemoteUtil : BaseRemoteUtil

+ (VideoRemoteUtil *)sharedUtil;

- (void)setCommonRemoteObject:(RemoteObject *)remoteObj withObject:(UserEntity *)object;

- (void)setCommonObject:(UserEntity *)object withRemoteObject:(RemoteObject *)remoteObj inManagedObjectContext:(NSManagedObjectContext *)context;

- (void)setNewRemoteObject:(RemoteObject *)remoteObj withObject:(UserEntity *)object;

//- (void)setNewRemoteObject:(RemoteObject *)remoteObj withObject:(UserEntity *)object withData:(NSData *)data;

- (void)setExistedRemoteObject:(RemoteObject *)remoteObj withObject:(UserEntity *)object;



@end
