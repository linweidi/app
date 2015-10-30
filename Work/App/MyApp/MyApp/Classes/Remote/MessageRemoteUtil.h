//
//  MessageRemoteUtil.h
//  MyApp
//
//  Created by Linwei Ding on 9/30/15.
//  Copyright (c) 2015 AppsFoundation. All rights reserved.
//

#import "AppHeader.h"
#import <Foundation/Foundation.h>
#import "UserBaseRemoteUtil.h"

@class JSQMessage;
@interface MessageRemoteUtil : UserBaseRemoteUtil


+ (MessageRemoteUtil *)sharedUtil;

#pragma mark -- private functions
- (void) setCommonObject:(BASE_REMOTE_UTIL_OBJ_TYPE)object withRemoteObject:(RemoteObject *)remoteObj inManagedObjectContext: (NSManagedObjectContext *)context;

- (void) setCommonRemoteObject:(RemoteObject *)remoteObj withAlert:(BASE_REMOTE_UTIL_OBJ_TYPE)object;

- (void)setExistedObject:(SystemEntity *)object withRemoteObject:(RemoteObject *)remoteObj inManagedObjectContext:(NSManagedObjectContext *)context ;

- (void)setNewObject:(SystemEntity *)object withRemoteObject:(RemoteObject *)remoteObj inManagedObjectContext:(NSManagedObjectContext *)context ;

//- (void)setExistedRemoteObject:(RemoteObject *)remoteObj withObject:(SystemEntity *)object;

- (void)setNewRemoteObject:(RemoteObject *)remoteObj withObject:(SystemEntity *)object;

#pragma mark -- external functions
- (void) loadRemoteMessages:(NSString *)chatId lastMessage:(JSQMessage *)lastMessage completionHandler:(REMOTE_ARRAY_BLOCK)block;

- (void) loadMessagesFromParse:(NSString *)chatId lastMessage:(JSQMessage *)lastMessage completionHandler:(REMOTE_ARRAY_BLOCK)block;

- (void) createMessageRemote:(NSString *)chatId text:(NSString *)text Video:(Video *)video Picture:(Picture *)picture completionHandler:(REMOTE_OBJECT_BLOCK)block;

@end
