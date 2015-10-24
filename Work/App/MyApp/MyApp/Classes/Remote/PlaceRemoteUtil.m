//
//  PlaceRemoteUtil.m
//  MyApp
//
//  Created by Linwei Ding on 10/21/15.
//  Copyright (c) 2015 Linweiding. All rights reserved.
//
#import "AppConstant.h"
#import "Place+Util.h"
#import "Thumbnail+Util.h"
#import "Picture+Util.h"
#import "ThumbnailRemoteUtil.h"
#import "PictureRemoteUtil.h"
#import "PlaceRemoteUtil.h"

@implementation PlaceRemoteUtil

+ (PlaceRemoteUtil *)sharedUtil {
    static dispatch_once_t predicate = 0;
    static PlaceRemoteUtil *sharedObject;
    
    dispatch_once(&predicate, ^{
        //initializing singleton object
        sharedObject = [[self alloc] init];
        
        sharedObject.className = PF_PLACE_CLASS_NAME;
    });
    return sharedObject;
}

- (void)setCommonObject:(SystemEntity *)object withRemoteObject:(RemoteObject *)remoteObj inManagedObjectContext:(NSManagedObjectContext *)context {
    NSAssert([object isKindOfClass:[Place class]], @"Type casting is wrong");
    Place * place = (Place *)object;
    place.closeTime = remoteObj[PF_PLACE_CLOSE_TIME];
    place.likes = remoteObj[PF_PLACE_LIKES];
    place.location = remoteObj[PF_PLACE_LOCATION];
    place.map = remoteObj[PF_PLACE_MAP];
    place.name = remoteObj[PF_PLACE_NAME];
    place.openTime = remoteObj[PF_PLACE_OPEN_TIME];
    place.parking = remoteObj[PF_PLACE_PARKING];
    place.price = remoteObj[PF_PLACE_PRICE];
    place.rankings = remoteObj[PF_PLACE_RANKINGS];
    place.tips = remoteObj[PF_PLACE_TIPS];
    place.type = remoteObj[PF_PLACE_TYPE];
}

- (void)setExistedObject:(SystemEntity *)object withRemoteObject:(RemoteObject *)remoteObj inManagedObjectContext:(NSManagedObjectContext *)context {
    [super setExistedObject:object withRemoteObject:remoteObj inManagedObjectContext:context];
    NSAssert([object isKindOfClass:[Place class]], @"Type casting is wrong");
    Place * place = (Place *)object;
    
    //picture
    //delete
#warning optimize in future
    NSMutableDictionary * pictObjDict = [[NSMutableDictionary alloc] init];
    for (Picture * picture in place.photos) {
        pictObjDict[picture.fileName] = picture;
    }
    
    for (PFObject * pictPF in remoteObj[PF_PLACE_PHOTOS]) {
        PFFile * pictFile = pictPF[PF_PICTURE_FILE];
        
        Picture * pictObj = pictObjDict[pictFile.name];
        if (pictObj) {
            //exist
            if ([pictPF.updatedAt compare:pictObj.updateTime] == NSOrderedSame) {
                // same update time
                // no need to update
            }
            else {
                [[PictureRemoteUtil sharedUtil] setExistedObject:pictObj withRemoteObject:pictPF inManagedObjectContext:context];
            }
            // remove
            [pictObjDict removeObjectForKey:pictFile.name];
            
        }
        else {
            // not exist
            // so new picture
            pictObj = [Picture createEntity:context];
            [[PictureRemoteUtil sharedUtil] setNewObject:pictObj withRemoteObject:pictPF inManagedObjectContext:context];
            [place addPhotosObject:pictObj];
        }
    }
    
    // create
    PFFile * filePicture = nil;
    NSArray * photosRT = remoteObj[PF_PLACE_PHOTOS];
    for (filePicture in photosRT) {
        Picture * picture = [Picture createEntity:context];
        picture.name = filePicture.name;
        picture.url = filePicture.url;
        [place addPhotosObject:picture];
    }

    // thumb
    PFObject * thumbnailPicture = remoteObj[PF_PLACE_THUMB];
    PFFile * thumbFile = thumbnailPicture[PF_THUMBNAIL_FILE];
    if (place.thumb.fileName != thumbFile.name) {
        
        [[ThumbnailRemoteUtil sharedUtil] setExistedObject:place.thumb withRemoteObject:thumbnailPicture inManagedObjectContext:context];
    }
    
}

- (void)setNewObject:(SystemEntity *)object withRemoteObject:(RemoteObject *)remoteObj inManagedObjectContext:(NSManagedObjectContext *)context {
    [super setNewObject:object withRemoteObject:remoteObj inManagedObjectContext:context];
    NSAssert([object isKindOfClass:[Place class]], @"Type casting is wrong");
    Place * place = (Place *)object;
    for (Picture * picture in place.photos) {
        [context deleteObject:picture];
        [place removePhotosObject:picture];
    }
    
    
    PFFile * filePicture = nil;
    NSArray * photosRT = remoteObj[PF_PLACE_PHOTOS];
    for (filePicture in photosRT) {
        Picture * picture = [Picture createEntity:context];
        picture.name = filePicture.name;
        picture.url = filePicture.url;
        [place.photos addPhotosObject:picture];
    }
    
    
    PFFile * thumbnailPicture = remoteObj[PF_USER_THUMBNAIL];
    //self.thumbnail = thumbnailPicture.name;
    Thumbnail * thumb =
    
    [Thumbnail thumbnailEntityWithPFUser:thumbnailPicture withUserID:remoteObj.objectId inManagedObjectContext:context ];
    place.thumb = thumb;
}


@end
