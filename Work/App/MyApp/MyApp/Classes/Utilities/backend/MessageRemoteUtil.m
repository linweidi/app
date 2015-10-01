//
//  MessageRemoteUtil.m
//  MyApp
//
//  Created by Linwei Ding on 9/30/15.
//  Copyright (c) 2015 AppsFoundation. All rights reserved.
//
#import "AppHeader.h"
#import "RemoteFile.h"
#import "JSQMessages.h"

#import "MessageRemoteUtil.h"

@implementation MessageRemoteUtil

+ (MessageRemoteUtil *)sharedUtil {
    static dispatch_once_t predicate = 0;
    static MessageRemoteUtil *sharedObject;
    
    dispatch_once(&predicate, ^{
        //initializing singleton object
        sharedObject = [[self alloc] init];
        
    });
    return sharedObject;
}

- (void) loadMessageFromParse:(NSString *)chatId lastMessage:(JSQMessage *)lastMessage completionHandler:(REMOTE_ARRAY_BLOCK)block {
    //lastMessage can be nil;
    PFQuery *query = [PFQuery queryWithClassName:PF_MESSAGE_CLASS_NAME];
    [query whereKey:PF_MESSAGE_GROUPID equalTo:chatId];
    if (lastMessage != nil) {
        [query whereKey:PF_MESSAGE_CREATEDAT greaterThan:lastMessage.date];
    }
    [query includeKey:PF_MESSAGE_USER];
    [query orderByDescending:PF_MESSAGE_CREATEDAT];
    [query setLimit:50];
    [query findObjectsInBackgroundWithBlock:block];
    
}

- (PFObject *) createMessageRemote:(NSString *)chatId text:(NSString *)text Video:(RemoteFile *)video Picture:(RemoteFile *)picture completionHandler:(REMOTE_BOOL_BLOCK)block{
    PFObject *object = [PFObject objectWithClassName:PF_MESSAGE_CLASS_NAME];
	object[PF_MESSAGE_USER] = [PFUser currentUser];
	object[PF_MESSAGE_GROUPID] = chatId;
	object[PF_MESSAGE_TEXT] = text;
	if (video != nil) object[PF_MESSAGE_VIDEO] = video.file;
	if (picture != nil) object[PF_MESSAGE_PICTURE] = picture.file;
	[object saveInBackgroundWithBlock:block];
    
}



@end
