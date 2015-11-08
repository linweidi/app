//
//  VideoRemoteUtil.m
//  MyApp
//
//  Created by Linwei Ding on 10/31/15.
//  Copyright © 2015 Linweiding. All rights reserved.
//
#import "Video+Util.h"
#import "VideoRemoteUtil.h"


@implementation VideoRemoteUtil


+ (VideoRemoteUtil *)sharedUtil {
    static dispatch_once_t predicate = 0;
    static VideoRemoteUtil *sharedObject;
    
    dispatch_once(&predicate, ^{
        //initializing singleton object
        sharedObject = [[self alloc] init];
        
        sharedObject.className = PF_VIDEO_CLASS_NAME;
    });
    return sharedObject;
}


#pragma mark -- private method

- (void)setCommonObject:(UserEntity *)object withRemoteObject:(RemoteObject *)remoteObj inManagedObjectContext:(NSManagedObjectContext *)context {
    NSAssert([object isKindOfClass:[Video class]], @"Type casting is wrong");
    Video * video = (Video *)object;
    
    video.name = remoteObj[PF_VIDEO_NAME];
    video.url = remoteObj[PF_VIDEO_URL];
    
    PFFile * filePF = remoteObj[PF_VIDEO_FILE];
    video.fileName = filePF.name;
    video.url = filePF.url;
}

- (void)setCommonRemoteObject:(RemoteObject *)remoteObj withObject:(UserEntity *)object {
    NSAssert([object isKindOfClass:[Video class]], @"Type casting is wrong");
    Video * video = (Video *)object;
    
    remoteObj[PF_VIDEO_NAME] = video.name ;
    remoteObj[PF_VIDEO_URL] = video.url;
}

- (void)setNewRemoteObject:(RemoteObject *)remoteObj withObject:(UserEntity *)object {
    [super setNewRemoteObject:remoteObj withObject:object];
    NSAssert([object isKindOfClass:[Video class]], @"Type casting is wrong");
    Video * video = (Video *)object;
    PFFile * filePF = [PFFile fileWithName:video.name data:video.dataVolatile];
    remoteObj[PF_VIDEO_FILE] = filePF;
}

//- (void)setNewRemoteObject:(RemoteObject *)remoteObj withObject:(UserEntity *)object withData:(NSData *)data {
//    [super setNewRemoteObject:remoteObj withObject:object];
//    NSAssert([object isKindOfClass:[Video class]], @"Type casting is wrong");
//    Video * video = (Video *)object;
//    PFFile * filePF = [PFFile fileWithName:video.name data:data];
//    remoteObj[PF_VIDEO_FILE] = filePF;
//    //    [filePF saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
//    //        if (!error) {
//    //            video.fileName = video.name;
//    //            video.url = filePF.url;
//    //        }
//    //    }];
//}

- (void)setExistedRemoteObject:(RemoteObject *)remoteObj withObject:(UserEntity *)object {
    [super setExistedRemoteObject:remoteObj withObject:object ];
    NSAssert([object isKindOfClass:[Video class]], @"Type casting is wrong");
    Video * video = (Video *)object;
    
    PFFile * oldFile = remoteObj[PF_VIDEO_FILE];
    if (![video.fileName isEqualToString: oldFile.name]) {
        PFFile * filePF = [PFFile fileWithName:video.fileName data:video.dataVolatile];
        remoteObj[PF_VIDEO_FILE] = filePF;
    }
    
    
    
    
    //    [filePF saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
    //        if (!error) {
    //            video.fileName = video.name;
    //            video.url = filePF.url;
    //        }
    //    }];
}



@end
