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

#pragma mark -- private functions
- (void)setCommonObject:(SystemEntity *)object withRemoteObject:(RemoteObject *)remoteObj inManagedObjectContext:(NSManagedObjectContext *)context ;

- (void)setCommonRemoteObject:(RemoteObject *)remoteObj withObject:(SystemEntity *)object;

- (void)setExistedObject:(SystemEntity *)object withRemoteObject:(RemoteObject *)remoteObj inManagedObjectContext:(NSManagedObjectContext *)context ;

- (void)setNewObject:(SystemEntity *)object withRemoteObject:(RemoteObject *)remoteObj inManagedObjectContext:(NSManagedObjectContext *)context ;

- (void)setExistedRemoteObject:(RemoteObject *)remoteObj withObject:(SystemEntity *)object;

- (void)setNewRemoteObject:(RemoteObject *)remoteObj withObject:(SystemEntity *)object;

#pragma mark -- external functions
- (void) loadRemotePlaces:(Place *)latestPlace completionHandler:(REMOTE_ARRAY_BLOCK)block ;

- (void) createRemotePlaces:(NSArray *)placeObjArray completionHandler:(REMOTE_OBJECT_BLOCK)block;

- (void) loadPlacesRecommended:(NSMutableArray *)array category:(EventCategory *)category;
@end
