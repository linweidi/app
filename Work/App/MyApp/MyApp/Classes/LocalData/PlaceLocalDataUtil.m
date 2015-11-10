//
//  PlaceLocalDataUtility.m
//  MyApp
//
//  Created by Linwei Ding on 11/8/15.
//  Copyright © 2015 Linweiding. All rights reserved.
//
#import "Place+Util.h"
#import "Picture+Util.h"
#import "Thumbnail+Util.h"
#import "PlaceLocalDataUtil.h"

#undef LOCAL_DATA_CLASS_TYPE
#define LOCAL_DATA_CLASS_TYPE Place

@implementation PlaceLocalDataUtil

+ (PlaceLocalDataUtil *)sharedUtil {
    static dispatch_once_t predicate = 0;
    static PlaceLocalDataUtil *sharedObject;
    
    dispatch_once(&predicate, ^{
        //initializing singleton object
        sharedObject = [[self alloc] init];
        
        sharedObject.className = PF_PLACE_CLASS_NAME;
        
        sharedObject.index = LOCAL_DATA_PLACE_INDEX;
    });
    return sharedObject;
}

#pragma mark - Inheritance methods

- (NSArray *)constructDataFromDict:(NSDictionary *)dict {
    
    NSMutableArray *resultArray = [NSMutableArray array];
    
    for (NSDictionary *obj in [dict allValues]) {
        
        LOCAL_DATA_CLASS_TYPE * object = [LOCAL_DATA_CLASS_TYPE createEntity:self.managedObjectContext];
        //Feedback *loadedData = [[Feedback alloc] init];
        
        [self setRandomValues:object data:obj];
        [resultArray addObject:object];
    }
    
    return [NSArray arrayWithArray:resultArray];
}

- (void) setRandomValues: (id) object data:(NSDictionary *)dict{
    [super setRandomValues:object data:dict];
    
    
    LOCAL_DATA_CLASS_TYPE * place = (LOCAL_DATA_CLASS_TYPE *)object;
    
    place.closeTime = dict[PF_PLACE_CLOSE_TIME];
    place.likes = dict[PF_PLACE_LIKES];
    place.location = dict[PF_PLACE_LOCATION];
    place.map = dict[PF_PLACE_MAP];
    place.name = dict[PF_PLACE_NAME];
    place.openTime = dict[PF_PLACE_OPEN_TIME];
    place.parking = dict[PF_PLACE_PARKING];
    place.price = dict[PF_PLACE_PRICE];
    place.rankings = dict[PF_PLACE_RANKINGS];
    place.tips = dict[PF_PLACE_TIPS];
    place.type = dict[PF_PLACE_TYPE];
    
    for (NSString * pictID in dict[PF_PLACE_PHOTOS]) {
        Picture * picture = [Picture entityWithID:pictID inManagedObjectContext:self.managedObjectContext];
        [place addPhotosObject:picture];
    }
    
    Thumbnail * thumb = [Thumbnail entityWithID:dict[PF_PLACE_THUMB] inManagedObjectContext:self.managedObjectContext];
    place.thumb = thumb;
}

//- (void) createLocalPlaces:(NSArray *)placeObjArray completionHandler:(REMOTE_OBJECT_BLOCK)block{
//    for (Place * place in placeObjArray) {
//        [self uploadCreateRemoteObject:place completionHandler:block];
//    }
//    
//}

@end
