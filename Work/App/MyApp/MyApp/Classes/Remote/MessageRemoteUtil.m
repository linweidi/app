//
//  MessageRemoteUtil.m
//  MyApp
//
//  Created by Linwei Ding on 9/30/15.
//  Copyright (c) 2015 AppsFoundation. All rights reserved.
//
#import "AppHeader.h"
#import "JSQMessages.h"
#import "ObjectEntity+Util.h"
#import "Message+Util.h"
#import "CurrentUser+Util.h"
#import "ConfigurationManager.h"
#import "Picture+Util.h"
#import "Video+Util.h"
#import "PictureRemoteUtil.h"
#import "VideoRemoteUtil.h"
#import "MessageRemoteUtil.h"

#define BASE_REMOTE_UTIL_OBJ_TYPE ObjectEntity*

@implementation MessageRemoteUtil


+ (MessageRemoteUtil *)sharedUtil {
    static dispatch_once_t predicate = 0;
    static MessageRemoteUtil *sharedObject;
    
    dispatch_once(&predicate, ^{
        //initializing singleton object
        sharedObject = [[self alloc] init];
        
        sharedObject.className = PF_MESSAGE_CLASS_NAME;
    });
    return sharedObject;
}

- (void) setCommonObject:(BASE_REMOTE_UTIL_OBJ_TYPE)object withRemoteObject:(RemoteObject *)remoteObj inManagedObjectContext: (NSManagedObjectContext *)context{
    NSAssert([object isKindOfClass:[Message class]], @"Type casting is wrong");
    Message * message = (Message *)object;
    
    message.user = [[ConfigurationManager sharedManager] getCurrentUser];
    message.chatID = remoteObj[PF_MESSAGE_GROUPID] ;
    message.text = remoteObj[PF_MESSAGE_TEXT];
    
}

- (void) setCommonRemoteObject:(RemoteObject *)remoteObj withAlert:(BASE_REMOTE_UTIL_OBJ_TYPE)object {
    NSAssert([object isKindOfClass:[Message class]], @"Type casting is wrong");
    Message * message = (Message *)object;
    
    
    remoteObj[PF_MESSAGE_USER] = [PFUser currentUser];
    remoteObj[PF_MESSAGE_GROUPID] = message.chatID;
    
    remoteObj[PF_MESSAGE_TEXT] = message.text;
}

- (void)setNewRemoteObject:(RemoteObject *)remoteObj withObject:(BASE_REMOTE_UTIL_OBJ_TYPE)object {
    [super setNewRemoteObject:remoteObj withObject:object];
    NSAssert([object isKindOfClass:[Message class]], @"Type casting is wrong");
    Message * message = (Message *)object;
    
    Picture * picture = message.picture;
    
    if (picture) {
//        PFObject * pictureRMT = [PFObject objectWithClassName:PF_PICTURE_CLASS_NAME];
//        pictureRMT[PF_PICTURE_NAME] = picture.name;
//        pictureRMT[PF_PICTURE_URL] = picture.url;
//        PFFile * pictFile = [PFFile fileWithName:picture.fileName data:picture.dataVolatile contentType:picture.url];
//        pictureRMT[PF_PICTURE_FILE] = pictFile;
//        
//        
//        
//        remoteObj[PF_MESSAGE_PICTURE] = pictureRMT;
        PFObject * pictureRMT = [PFObject objectWithClassName:PF_PICTURE_CLASS_NAME];
        [[PictureRemoteUtil sharedUtil] setNewRemoteObject:pictureRMT withObject:message.picture];
        remoteObj[PF_MESSAGE_PICTURE] = pictureRMT;
    }

    Video * video = message.video;
    
    if (video) {
//        PFObject * videoRMT = [PFObject objectWithClassName:PF_VIDEO_CLASS_NAME];
//        videoRMT[PF_VIDEO_NAME] = video.name;
//        videoRMT[PF_VIDEO_URL] = video.url;
//        PFFile * videoFile = [PFFile fileWithName:video.fileName data:video.dataVolatile contentType:video.url];
//        videoRMT[PF_VIDEO_FILE] = videoFile;
//        
//        
//        remoteObj[PF_MESSAGE_VIDEO] = videoRMT;
        PFObject * videoRMT = [PFObject objectWithClassName:PF_VIDEO_CLASS_NAME];
        [[VideoRemoteUtil sharedUtil] setNewRemoteObject:videoRMT withObject:message.video];
        remoteObj[PF_MESSAGE_VIDEO] = videoRMT;
    }

}

- (void)setNewObject:(BASE_REMOTE_UTIL_OBJ_TYPE)object withRemoteObject:(RemoteObject *)remoteObj inManagedObjectContext:(NSManagedObjectContext *)context {
    [super setNewObject:object withRemoteObject:remoteObj inManagedObjectContext:context];
    NSAssert([object isKindOfClass:[Message class]], @"Type casting is wrong");
    Message * message = (Message *)object;
    
    //picture
    Picture * picture;
    PFObject * pictureRMT= remoteObj[PF_MESSAGE_PICTURE];
    if (pictureRMT.updatedAt) {
//        PFFile * pictFile = pictureRMT[PF_PICTURE_FILE];
//        picture = [Picture createEntity:object.managedObjectContext];
//        picture.name = pictureRMT[PF_PICTURE_NAME];
//        picture.url = pictureRMT[PF_PICTURE_URL];
//        picture.fileName = pictFile.name;
//        picture.url = pictFile.url;
//        
//        message.picture = picture;
        
        picture = [Picture createEntity:self.managedObjectContext];
        [[PictureRemoteUtil sharedUtil] setNewObject:picture withRemoteObject:pictureRMT inManagedObjectContext:self.managedObjectContext];
        message.picture = picture;
    }
    
    Video * video;
    PFObject * videoRMT= remoteObj[PF_MESSAGE_VIDEO];
    if (videoRMT.updatedAt) {
//        PFFile * videoFile = videoRMT[PF_VIDEO_FILE];
//        video = [Video createEntity:object.managedObjectContext];
//        video.name = videoRMT[PF_VIDEO_NAME];
//        video.url = videoRMT[PF_VIDEO_URL];
//        video.fileName = videoFile.name;
//        video.url = videoFile.url;
//        
//        message.video = video;
        video = [Video createEntity:self.managedObjectContext];
        [[VideoRemoteUtil sharedUtil] setNewObject:video withRemoteObject:videoRMT inManagedObjectContext:self.managedObjectContext];
        message.video = video;
    }
    
}


- (void)setExistedObject:(BASE_REMOTE_UTIL_OBJ_TYPE)object withRemoteObject:(RemoteObject *)remoteObj inManagedObjectContext:(NSManagedObjectContext *)context {
    [super setExistedObject:object withRemoteObject:remoteObj inManagedObjectContext:context];
    NSAssert([object isKindOfClass:[Message class]], @"Type casting is wrong");
    Message * message = (Message *)object;
    
    // not necessary to update message object
    // only create when locally deleted
    
    //picture
    PFObject * pictureRMT = remoteObj[PF_MESSAGE_PICTURE];
    if (pictureRMT.updatedAt) {
        Picture * picture = message.picture;
        if (picture) {
            if ([pictureRMT.updatedAt compare:picture.updateTime] == NSOrderedDescending) {
                [[PictureRemoteUtil sharedUtil] setExistedObject:picture withRemoteObject:pictureRMT inManagedObjectContext:context];
            }
        }
        else {
            picture = [Picture createEntity:context];
            [[PictureRemoteUtil sharedUtil] setNewObject:picture withRemoteObject:pictureRMT inManagedObjectContext:context];
        }
        
        message.picture = picture;
    }
    
    PFObject * videoRMT = remoteObj[PF_MESSAGE_VIDEO];
    if (videoRMT.updatedAt) {
        Video * video = message.video;
        if (video) {
            if ([videoRMT.updatedAt compare:video.updateTime] == NSOrderedDescending) {
                [[VideoRemoteUtil sharedUtil] setExistedObject:video withRemoteObject:videoRMT inManagedObjectContext:context];
            }
        }
        else {
            video = [Video createEntity:context];
            [[VideoRemoteUtil sharedUtil] setNewObject:video withRemoteObject:videoRMT inManagedObjectContext:context];
        }
        
        message.video = video;
    }
//    Video * video;
//    PFObject * videoRMT= remoteObj[PF_MESSAGE_VIDEO];
//    if (videoRMT.updatedAt && [videoRMT.updatedAt compare:message.video.updateTime] == NSOrderedDescending) {
//        if (message.video) {
////            PFFile * videoFile = videoRMT[PF_VIDEO_FILE];
////            video = [Video createEntity:object.managedObjectContext];
////            video.name = videoRMT[PF_VIDEO_NAME];
////            video.url = videoRMT[PF_VIDEO_URL];
////            video.fileName = videoFile.name;
////            video.url = videoFile.url;
////            
////            message.video = video;
//            
//            video = [Video createEntity:self.managedObjectContext];
//            [[VideoRemoteUtil sharedUtil] setExistedObject:video withRemoteObject:videoRMT inManagedObjectContext:self.managedObjectContext];
//            message.video = video;
//        }
//
//    }
}

- (void) loadMessagesFromParse:(NSString *)chatId lastMessage:(JSQMessage *)lastMessage completionHandler:(REMOTE_ARRAY_BLOCK)block {
    //lastMessage can be nil;
    PFQuery *query = [PFQuery queryWithClassName:PF_MESSAGE_CLASS_NAME];
    [query whereKey:PF_MESSAGE_GROUPID equalTo:chatId];

    [query includeKey:PF_MESSAGE_USER];
    
    [query orderByDescending:PF_MESSAGE_CREATEDAT];
    
    [query setLimit:MESSAGEVIEW_ITEM_NUM];
    if (lastMessage != nil) {
        [query whereKey:PF_MESSAGE_CREATEDAT greaterThan:lastMessage.date];
        [self downloadObjectsWithQuery:query completionHandler:^(NSArray *remoteObjs, NSArray *objects, NSError *error) {
            block(objects, error);
        }];
    }
    else {
        [self downloadCreateObjectsWithQuery:query completionHandler:^(NSArray *remoteObjs, NSArray *objects, NSError *error) {
            block(objects, error);
        }];
    }
    
    
    
}

- (void) loadRemoteMessages:(NSString *)chatId lastMessage:(JSQMessage *)lastMessage completionHandler:(REMOTE_ARRAY_BLOCK)block {
    [self loadMessagesFromParse:chatId lastMessage:lastMessage completionHandler:block];
}

- (void) createRemoteMessage:(NSString *)chatId text:(NSString *)text Video:(Video *)video Picture:(Picture *)picture completionHandler:(REMOTE_OBJECT_BLOCK)block{
    
    Message * message = [Message createEntity:nil];
    message.user = [[ConfigurationManager sharedManager] getCurrentUser];
    message.chatID = chatId;
    message.text = text;
    message.picture = picture;
    message.video = video;
    [self uploadCreateRemoteObject:message  completionHandler:block];

}



@end
