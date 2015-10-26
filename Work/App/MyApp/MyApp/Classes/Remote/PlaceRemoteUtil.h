//
//  PlaceRemoteUtil.h
//  MyApp
//
//  Created by Linwei Ding on 10/21/15.
//  Copyright (c) 2015 Linweiding. All rights reserved.
//

#import "SystemBaseRemoteUtil.h"
#import <Foundation/Foundation.h>

@interface PlaceRemoteUtil : SystemBaseRemoteUtil

+ (PlaceRemoteUtil *)sharedUtil;

- (void)setCommonObject:(SystemEntity *)object withRemoteObject:(RemoteObject *)remoteObj inManagedObjectContext:(NSManagedObjectContext *)context ;

- (void)setExistedObject:(SystemEntity *)object withRemoteObject:(RemoteObject *)remoteObj inManagedObjectContext:(NSManagedObjectContext *)context ;

- (void)setNewObject:(SystemEntity *)object withRemoteObject:(RemoteObject *)remoteObj inManagedObjectContext:(NSManagedObjectContext *)context ;

- (void)setCommonRemoteObject:(RemoteObject *)remoteObj withObject:(SystemEntity *)object;

- (void)setExistedRemoteObject:(RemoteObject *)remoteObj withObject:(SystemEntity *)object;

- (void)setNewRemoteObject:(RemoteObject *)remoteObj withObject:(SystemEntity *)object;

@end
