//
//  RecentPhoto+Create.m
//  TopRegions
//
//  Created by Linwei Ding on 7/30/15.
//  Copyright (c) 2015 Linwei Ding. All rights reserved.
//

#import "RecentPhoto+Create.h"

@implementation RecentPhoto (Create)

static NSInteger countRecentPhotos = 0;

static const int MAX_RECENT_PHOTOS_NUM = 5;
static const int LOAD_RECENT_PHOTOS_NUM = 5;

+ (RecentPhoto *)createRecentPhotoWithDate:(NSDate *)date
                inManagedObjectContext:(NSManagedObjectContext *)context
{
    
    NSAssert(context, @"the managed object context is nil");
    
    RecentPhoto * recent = nil;
    

    if (date) {
        recent = [NSEntityDescription insertNewObjectForEntityForName:@"RecentPhoto"
                                                     inManagedObjectContext:context];
        recent.date = date;
        
        if (countRecentPhotos < MAX_RECENT_PHOTOS_NUM) {
            countRecentPhotos++;
        }
        else {
            // keep countRecentPhotos;
            // remove the oldeset photo
            [self removeEarliestRecentPhotoInManagedObjectContext:context];
        }
        
    }
    
    return recent;
}

+ (void) removeEarliestRecentPhotoInManagedObjectContext:(NSManagedObjectContext *)context {
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"RecentPhoto"];
    request.fetchLimit = 1;
    request.predicate = nil;
    request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"date" ascending:NO]];
    
    NSError *error;
    NSArray *matches = [context executeFetchRequest:request error:&error];
    if (!matches || error || ([matches count] != 1)) {
        NSAssert(NO, @"fetch fails, %@", NSStringFromSelector(_cmd));
    }
    [context deleteObject:[matches firstObject]];
}

+ (NSArray *) loadAllRecentPhotosInManagedObjectContext:(NSManagedObjectContext *)context  {
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"RecentPhoto"];
    request.fetchLimit = LOAD_RECENT_PHOTOS_NUM;
    request.predicate = nil;
    request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"date" ascending:NO]];
    
    NSError *error;
    NSArray *matches = [context executeFetchRequest:request error:&error];
    
    if (!matches || error ) {
        NSAssert(NO, @"fetch fails, %@", NSStringFromSelector(_cmd));
    }
    return matches;
}

@end
