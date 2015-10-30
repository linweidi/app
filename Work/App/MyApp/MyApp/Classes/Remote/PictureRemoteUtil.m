//
//  PictureRemoteUtil.m
//  MyApp
//
//  Created by Linwei Ding on 10/23/15.
//  Copyright © 2015 Linweiding. All rights reserved.
//
#import "Picture+Util.h"
#import "PictureRemoteUtil.h"


@implementation PictureRemoteUtil


+ (PictureRemoteUtil *)sharedUtil {
    static dispatch_once_t predicate = 0;
    static PictureRemoteUtil *sharedObject;
    
    dispatch_once(&predicate, ^{
        //initializing singleton object
        sharedObject = [[self alloc] init];
        
        sharedObject.className = PF_PICTURE_CLASS_NAME;
    });
    return sharedObject;
}


#pragma mark -- private method

- (void)setCommonObject:(UserEntity *)object withRemoteObject:(RemoteObject *)remoteObj inManagedObjectContext:(NSManagedObjectContext *)context {
    NSAssert([object isKindOfClass:[Picture class]], @"Type casting is wrong");
    Picture * picture = (Picture *)object;
    
    picture.name = remoteObj[PF_PICTURE_NAME];
    picture.url = remoteObj[PF_PICTURE_URL];
    
    PFFile * filePF = remoteObj[PF_PICTURE_FILE];
    picture.fileName = filePF.name;
    picture.url = filePF.url;
}

- (void)setCommonRemoteObject:(RemoteObject *)remoteObj withObject:(UserEntity *)object {
    NSAssert([object isKindOfClass:[Picture class]], @"Type casting is wrong");
    Picture * picture = (Picture *)object;
    
    remoteObj[PF_PICTURE_NAME] = picture.name ;
    remoteObj[PF_PICTURE_URL] = picture.url;
}

- (void)setNewRemoteObject:(RemoteObject *)remoteObj withObject:(UserEntity *)object {
    [super setNewRemoteObject:remoteObj withObject:object];
    NSAssert([object isKindOfClass:[Picture class]], @"Type casting is wrong");
    Picture * picture = (Picture *)object;
    PFFile * filePF = [PFFile fileWithName:picture.name data:picture.data];
    remoteObj[PF_PICTURE_FILE] = filePF;
}

//- (void)setNewRemoteObject:(RemoteObject *)remoteObj withObject:(UserEntity *)object withData:(NSData *)data {
//    [super setNewRemoteObject:remoteObj withObject:object];
//    NSAssert([object isKindOfClass:[Picture class]], @"Type casting is wrong");
//    Picture * picture = (Picture *)object;
//    PFFile * filePF = [PFFile fileWithName:picture.name data:data];
//    remoteObj[PF_PICTURE_FILE] = filePF;
//    //    [filePF saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
//    //        if (!error) {
//    //            picture.fileName = picture.name;
//    //            picture.url = filePF.url;
//    //        }
//    //    }];
//}

- (void)setExistedRemoteObject:(RemoteObject *)remoteObj withObject:(UserEntity *)object {
    [super setExistedRemoteObject:remoteObj withObject:object ];
    NSAssert([object isKindOfClass:[Picture class]], @"Type casting is wrong");
    Picture * picture = (Picture *)object;
    
    PFFile * oldFile = remoteObj[PF_PICTURE_FILE];
    if (![picture.fileName isEqualToString: oldFile.name]) {
        PFFile * filePF = [PFFile fileWithName:picture.fileName data:picture.data];
        remoteObj[PF_PICTURE_FILE] = filePF;
    }
    
    
    
    
    //    [filePF saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
    //        if (!error) {
    //            picture.fileName = picture.name;
    //            picture.url = filePF.url;
    //        }
    //    }];
}

@end
