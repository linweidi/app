//
//  RecentPhoto+Create.h
//  TopRegions
//
//  Created by Linwei Ding on 7/30/15.
//  Copyright (c) 2015 Linwei Ding. All rights reserved.
//
#import "RecentPhoto.h"


@interface RecentPhoto (Create)
+ (RecentPhoto *)createRecentPhotoWithDate:(NSDate *)date
              inManagedObjectContext:(NSManagedObjectContext *)context;

+ (void) removeEarliestRecentPhotoInManagedObjectContext:(NSManagedObjectContext *)context ;

+ (NSArray *) loadAllRecentPhotosInManagedObjectContext:(NSManagedObjectContext *)context ;

@end
