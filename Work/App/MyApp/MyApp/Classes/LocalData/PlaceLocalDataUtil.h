//
//  PlaceLocalDataUtility.h
//  MyApp
//
//  Created by Linwei Ding on 11/8/15.
//  Copyright © 2015 Linweiding. All rights reserved.
//

#import "BaseLocalDataUtil.h"

@class EventCategory;
@interface PlaceLocalDataUtil : BaseLocalDataUtil

+ (PlaceLocalDataUtil *)sharedUtil;

- (void) setRandomValues: (id) object data:(NSDictionary *)dict;

- (NSArray *)constructDataFromDict:(NSDictionary *)dict;

//- (void) createLocalPlaces:(NSArray *)placeObjArray completionHandler:(REMOTE_OBJECT_BLOCK)block;

- (NSArray *) loadPlacesRecommended:(NSString *)localID ;
@end
