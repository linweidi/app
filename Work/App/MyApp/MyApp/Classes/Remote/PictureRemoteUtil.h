//
//  PictureRemoteUtil.h
//  MyApp
//
//  Created by Linwei Ding on 10/23/15.
//  Copyright © 2015 Linweiding. All rights reserved.
//

#import "BaseRemoteUtil.h"


@class Picture;
@interface PictureRemoteUtil : BaseRemoteUtil

+ (PictureRemoteUtil *)sharedUtil;

//- (void)setExistedObject:(UserEntity *)object withRemoteObject:(RemoteObject *)remoteObj inManagedObjectContext:(NSManagedObjectContext *)context ;
//
//- (void)setNewObject:(UserEntity *)object withRemoteObject:(RemoteObject *)remoteObj inManagedObjectContext:(NSManagedObjectContext *)context ;
//
//- (void)setNewRemoteObject:(RemoteObject *)remoteObj withObject:(UserEntity *)object;
//
//- (void)setExistedRemoteObject:(RemoteObject *)remoteObj withObject:(UserEntity *)object;
//


- (void)setCommonRemoteObject:(RemoteObject *)remoteObj withObject:(UserEntity *)object;

- (void)setCommonObject:(UserEntity *)object withRemoteObject:(RemoteObject *)remoteObj inManagedObjectContext:(NSManagedObjectContext *)context;

- (void)setNewRemoteObject:(RemoteObject *)remoteObj withObject:(UserEntity *)object;

- (void)setNewRemoteObject:(RemoteObject *)remoteObj withObject:(UserEntity *)object withData:(NSData *)data;

- (void)setExistedRemoteObject:(RemoteObject *)remoteObj withObject:(UserEntity *)object ;


@end
