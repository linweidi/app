//
//  ThumbnailRemoteUtil.m
//  MyApp
//
//  Created by Linwei Ding on 10/22/15.
//  Copyright © 2015 Linweiding. All rights reserved.
//

#import "Thumbnail+Util.h"
#import "User+Util.h"
#import "ThumbnailRemoteUtil.h"

@implementation ThumbnailRemoteUtil


+ (ThumbnailRemoteUtil *)sharedUtil {
    static dispatch_once_t predicate = 0;
    static ThumbnailRemoteUtil *sharedObject;
    
    dispatch_once(&predicate, ^{
        //initializing singleton object
        sharedObject = [[self alloc] init];
        
        sharedObject.className = PF_THUMBNAIL_CLASS_NAME;
    });
    return sharedObject;
}


#pragma mark -- private method

// populate create time and update time
- (Thumbnail *) thumbnailEntityWithRemoteFile:(RemoteObject *)thumbFileRF withUserID:(NSString *)userID inManagedObjectContext: (NSManagedObjectContext *)context {
    UserManager * manager = [UserManager sharedUtil];

    Thumbnail *thumbObj = nil   ;
    NSString * thumbName = nil;
    UserContext * userContext = nil;
    User * user = nil;
    if ([manager exists:userID]) {
        //thumb exists in core data
        
        userContext = [manager getContext:userID];
        user = userContext.user;
        thumbObj = userContext.thumb;
        thumbName = userContext.thumbName;
        
        if (thumbName == thumbFileRF.objectId) {
            //thumbnail already exists
            // do nothing
        }
        else {
            
            //thumbnail different, so update
            if (thumbObj) {
                
                //populate thumb's values
                [self setExistedObject:thumbObj withRemoteObject:thumbFileRF inManagedObjectContext:context ];
                
            }
            else {
                NSAssert(NO, @"insert thumbnail fails");
            }
        }
    }
    else {
        // thumbnail is not initialized
        // no thumbnail exists, no user exists
        thumbObj = [NSEntityDescription insertNewObjectForEntityForName:PF_THUMBNAIL_CLASS_NAME inManagedObjectContext:context];
        if (thumbObj) {
            [self setNewObject:thumbObj withRemoteObject:thumbFileRF inManagedObjectContext:context];
        }
        else {
            NSAssert(NO, @"insert thumbnail fails");
        }
    }
    
    return thumbObj;
}

- (void)setCommonObject:(UserEntity *)object withRemoteObject:(RemoteObject *)remoteObj inManagedObjectContext:(NSManagedObjectContext *)context {
    NSAssert([object isKindOfClass:[Thumbnail class]], @"Type casting is wrong");
    Thumbnail * thumb = (Thumbnail *)object;
    
    thumb.name = remoteObj[PF_THUMBNAIL_NAME];
//    PFFile * filePF = remoteObj[PF_THUMBNAIL_FILE];
//    thumb.fileName = filePF.name;
//    thumb.globalID = remoteObj.objectId;
//    thumb.createTime = remoteObj.createdAt;
//    thumb.updateTime = remoteObj.updatedAt;
    thumb.url = remoteObj[PF_THUMBNAIL_URL];
    
    PFFile * filePF = remoteObj[PF_THUMBNAIL_FILE];
    thumb.fileName = filePF.name;
    thumb.url = filePF.url;
}

//- (void)setNewObject:(UserEntity *)object withRemoteObject:(RemoteObject *)remoteObj inManagedObjectContext:(NSManagedObjectContext *)context {
//    [super setNewObject:object withRemoteObject:remoteObj inManagedObjectContext:context];
//    NSAssert([object isKindOfClass:[Thumbnail class]], @"Type casting is wrong");
//    Thumbnail * thumb = (Thumbnail *)object;
//    
//    PFFile * filePF = remoteObj[PF_THUMBNAIL_FILE];
//    
//    
////    [filePF getDataInBackgroundWithBlock:^(NSData * _Nullable data, NSError * _Nullable error) {
////        if (!error) {
////            thumb.fileName = filePF.name;
////            thumb.data = data;
////        }
////    }];
//    
//}
//
//- (void)setExistedObject:(UserEntity *)object withRemoteObject:(RemoteObject *)remoteObj inManagedObjectContext:(NSManagedObjectContext *)context {
//    [super setExistedObject:object withRemoteObject:remoteObj inManagedObjectContext:context];
//    NSAssert([object isKindOfClass:[Thumbnail class]], @"Type casting is wrong");
//    Thumbnail * thumb = (Thumbnail *)object;
//    
//    PFFile * filePF = remoteObj[PF_THUMBNAIL_FILE];
//    thumb.fileName = filePF.name;
//    thumb.url = filePF.url;
//    
//    
//    if (thumb.fileName != filePF.name) {
//        [filePF getDataInBackgroundWithBlock:^(NSData * _Nullable data, NSError * _Nullable error) {
//            if (!error) {
//                thumb.fileName = filePF.name;
//                thumb.data = data;
//            }
//        }];
//    }
//}

- (void)setCommonRemoteObject:(RemoteObject *)remoteObj withObject:(UserEntity *)object {
    NSAssert([object isKindOfClass:[Thumbnail class]], @"Type casting is wrong");
    Thumbnail * thumb = (Thumbnail *)object;
    
    remoteObj[PF_THUMBNAIL_NAME] = thumb.name ;
    remoteObj[PF_THUMBNAIL_URL] = thumb.url;
}

- (void)setNewRemoteObject:(RemoteObject *)remoteObj withObject:(UserEntity *)object {
    [super setNewRemoteObject:remoteObj withObject:object];
    NSAssert([object isKindOfClass:[Thumbnail class]], @"Type casting is wrong");
    Thumbnail * thumb = (Thumbnail *)object;
    
    PFFile * filePF = [PFFile fileWithName:thumb.name data:thumb.data];
    remoteObj[PF_THUMBNAIL_FILE] = filePF;
//    [filePF saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
//        if (!error) {
//            thumb.fileName = thumb.name;
//            thumb.url = filePF.url;
//        }
//    }];
}

- (void)setExistedRemoteObject:(RemoteObject *)remoteObj withObject:(UserEntity *)object {
    [super setExistedRemoteObject:remoteObj withObject:object ];
    NSAssert([object isKindOfClass:[Thumbnail class]], @"Type casting is wrong");
    Thumbnail * thumb = (Thumbnail *)object;
    
    PFFile * oldFile = remoteObj[PF_THUMBNAIL_FILE];
    if (![thumb.fileName isEqualToString: oldFile.name]) {
        PFFile * filePF = [PFFile fileWithName:thumb.fileName data:thumb.data];
        remoteObj[PF_THUMBNAIL_FILE] = filePF;
    }
    

    
//    [filePF saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
//        if (!error) {
//            thumb.fileName = thumb.name;
//            thumb.url = filePF.url;
//        }
//    }];
}

//- (void) setFile:(BASE_REMOTE_UTIL_OBJ_TYPE)object withRemoteFile:(RemoteFile *)remoteFile {
//    NSAssert([object isKindOfClass:[Thumbnail class]], @"Type casting is wrong");
//    Thumbnail * thumb = (Thumbnail *)object;
//    thumb.name = remoteFile.name;
//    thumb.url = remoteFile.url;
//    
//    [remoteFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
//        if (!error) {
//            
//            thumb.data = data;
//            thumb.globalID = remoteFile.name;
//            thumb.createTime =
//        }
//    }];
//}

// 1. get file object
// 2. populate remote file. populate data for save/update or populate url
// 3. save remote file
//
//- (void) setCommonRemoteFile:(RemoteFile *)remoteFile withObject:(BASE_REMOTE_UTIL_OBJ_TYPE)object{
//    NSAssert([object isKindOfClass:[Thumbnail class]], @"Type casting is wrong");
//    Thumbnail * thumb = (Thumbnail *)object;
//    
//    remoteFile.data = thumb.data;
//    //remoteFile.url = thumb.url ;
//    
//    return [PFFile fileWithName:<#(nullable NSString *)#> contentsAtPath:<#(nonnull NSString *)#>]
////}

@end
