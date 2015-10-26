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

- (void)setCommonRemoteObject:(RemoteObject *)remoteObj withObject:(SystemEntity *)object {
    NSAssert([object isKindOfClass:[Place class]], @"Type casting is wrong");
    Place * place = (Place *)object;
    remoteObj[PF_PLACE_CLOSE_TIME] = place.closeTime ;
    remoteObj[PF_PLACE_LIKES] = place.likes ;
    remoteObj[PF_PLACE_LOCATION] = place.location ;
    remoteObj[PF_PLACE_MAP] = place.map ;
    remoteObj[PF_PLACE_NAME] = place.name ;
    remoteObj[PF_PLACE_OPEN_TIME] = place.openTime ;
    remoteObj[PF_PLACE_PARKING] = place.parking ;
    remoteObj[PF_PLACE_PRICE] = place.price ;
    remoteObj[PF_PLACE_RANKINGS] = place.rankings ;
    remoteObj[PF_PLACE_TIPS] = place.tips ;
    remoteObj[PF_PLACE_TYPE] = place.type ;
}

- (void)setExistedObject:(SystemEntity *)object withRemoteObject:(RemoteObject *)remoteObj inManagedObjectContext:(NSManagedObjectContext *)context {
    [super setExistedObject:object withRemoteObject:remoteObj inManagedObjectContext:context];
    NSAssert([object isKindOfClass:[Place class]], @"Type casting is wrong");
    Place * place = (Place *)object;
    
    //picture
    //delete
    NSMutableDictionary * pictObjDict = [[NSMutableDictionary alloc] init];
    for (Picture * picture in place.photos) {
        pictObjDict[picture.globalID] = picture;
    }
    
    for (PFObject * pictPF in remoteObj[PF_PLACE_PHOTOS]) {
        //PFFile * pictFile = pictPF[PF_PICTURE_FILE];
        
        Picture * pictObj = pictObjDict[pictPF.objectId];
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
            [pictObjDict removeObjectForKey:pictPF.objectId];
            
        }
        else {
            // not exist
            // so new picture
            pictObj = [Picture createEntity:context];
            [[PictureRemoteUtil sharedUtil] setNewObject:pictObj withRemoteObject:pictPF inManagedObjectContext:context];
            [place addPhotosObject:pictObj];
        }
    }
    
//    // create
//    PFFile * filePicture = nil;
//    NSArray * photosRT = remoteObj[PF_PLACE_PHOTOS];
//    for (filePicture in photosRT) {
//        Picture * picture = [Picture createEntity:context];
//        picture.name = filePicture.name;
//        picture.url = filePicture.url;
//        [place addPhotosObject:picture];
//    }

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
    
//    for (Picture * picture in place.photos) {
//        [context deleteObject:picture];
//        [place removePhotosObject:picture];
//    }
    
    
    RemoteObject * filePicture = nil;
    NSArray * photosRT = remoteObj[PF_PLACE_PHOTOS];
    for (filePicture in photosRT) {
        Picture * picture = [Picture createEntity:context];
        [[PictureRemoteUtil sharedUtil] setNewObject:picture withRemoteObject:filePicture inManagedObjectContext:context];
        [place addPhotosObject:picture];
        
    }
    
    
    PFObject * thumbnailPicture = remoteObj[PF_PLACE_THUMB];
    //self.thumbnail = thumbnailPicture.name;
    Thumbnail * thumb = [Thumbnail createEntity:context];
    [[ThumbnailRemoteUtil sharedUtil] setNewObject:thumb withRemoteObject:thumbnailPicture inManagedObjectContext:context];
    place.thumb = thumb;
}



- (void)setExistedRemoteObject:(RemoteObject *)remoteObj withObject:(SystemEntity *)object {
    [super setExistedRemoteObject:remoteObj withObject:object];
    NSAssert([object isKindOfClass:[Place class]], @"Type casting is wrong");
    Place * place = (Place *)object;
    
    //photos
    //
    NSMutableDictionary * dict = [[NSMutableDictionary alloc] init];
    NSArray * photosRMT = remoteObj[PF_PLACE_PHOTOS];
    for (RemoteObject * pictRMT in photosRMT) {
        dict[pictRMT.objectId] = pictRMT;
    }
    
    NSMutableArray * photosRF = [[NSMutableArray alloc] init];
    PictureRemoteUtil * pictUtil = [PictureRemoteUtil sharedUtil];
    for (Picture * picture in place.photos) {
        
        RemoteObject * pictRMT = dict[picture.globalID];
        if (pictRMT) {
            // exist
            // check if need update
            [pictUtil setExistedRemoteObject:pictRMT withObject:picture];
        }
        else {
            // not exist
            // so create one
            RemoteObject * newPictRMT = [PFObject objectWithClassName:PF_PICTURE_CLASS_NAME];
            [pictUtil setNewRemoteObject:newPictRMT withObject:picture];
            pictRMT = newPictRMT;
        }
    
        [photosRF addObject:pictRMT];
    }
    remoteObj[PF_PLACE_PHOTOS] = photosRF;
    
    
    //thumb
    PFObject * thumbRMT = [PFObject objectWithClassName:PF_THUMBNAIL_CLASS_NAME];
    [[ThumbnailRemoteUtil sharedUtil] setNewRemoteObject:thumbRMT withObject:place.thumb];
    remoteObj[PF_PLACE_THUMB] = thumbRMT;
}

- (void)setNewRemoteObject:(RemoteObject *)remoteObj withObject:(SystemEntity *)object {
    [super setNewRemoteObject:remoteObj withObject:object];
    NSAssert([object isKindOfClass:[Place class]], @"Type casting is wrong");
    Place * place = (Place *)object;
    
    //photos
    //NSArray * photosRF = remoteObj[PF_PLACE_PHOTOS];

    
    NSMutableArray * photosRF = [[NSMutableArray alloc] init];
    PictureRemoteUtil * pictUtil = [PictureRemoteUtil sharedUtil];
    for (Picture * picture in place.photos) {
        RemoteObject * pictRF = [PFObject objectWithClassName:PF_PICTURE_CLASS_NAME];
        [pictUtil setNewRemoteObject:pictRF withObject:picture];
        [photosRF addObject:pictRF];
    }
    remoteObj[PF_PLACE_PHOTOS] = photosRF;
    
    
    //thumb
    PFObject * thumbRMT = [PFObject objectWithClassName:PF_THUMBNAIL_CLASS_NAME];
    [[ThumbnailRemoteUtil sharedUtil] setNewRemoteObject:thumbRMT withObject:place.thumb];
    remoteObj[PF_PLACE_THUMB] = thumbRMT;
}


@end
