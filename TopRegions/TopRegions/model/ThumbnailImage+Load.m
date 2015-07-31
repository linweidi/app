//
//  ThumbnailImage+Load.m
//  TopRegions
//
//  Created by Linwei Ding on 7/30/15.
//  Copyright (c) 2015 Linwei Ding. All rights reserved.
//

#import "ThumbnailImage+Load.h"

@implementation ThumbnailImage (Load)
+ (ThumbnailImage *)thumbnailWithURL:(NSString *)imageURL
             inManagedObjectContext:(NSManagedObjectContext *)context
{
    ThumbnailImage *image = nil;
    
    if ([imageURL length]) {
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"ThumbnailImage"];
        request.predicate = [NSPredicate predicateWithFormat:@"imageURL = %@", imageURL];
        
        NSError *error;
        NSArray *matches = [context executeFetchRequest:request error:&error];
        
        if (!matches || ([matches count] > 1)) {
            // handle error
        } else if (![matches count]) {
            image = [NSEntityDescription insertNewObjectForEntityForName:@"ThumbnailImage"
                                                  inManagedObjectContext:context];
            image.imageURL = imageURL;
        } else {
            image = [matches lastObject];
        }
    }
    
    return image;
}

@end
