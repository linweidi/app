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

@end
