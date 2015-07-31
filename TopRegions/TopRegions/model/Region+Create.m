//
//  Region+Create.m
//  TopRegions
//
//  Created by Linwei Ding on 7/30/15.
//  Copyright (c) 2015 Linwei Ding. All rights reserved.
//

#import "Region+Create.h"

@implementation Region (Create)


+ (Region *)regionWithName:(NSString *)name
    inManagedObjectContext:(NSManagedObjectContext *)context {
    Region * region = nil;
    
    if ([name length]) {
        NSFetchRequest * request = [NSFetchRequest fetchRequestWithEntityName:@"Region"];
        request.predicate = [NSPredicate predicateWithFormat:@"name = %@", name];
        NSError *error;
        NSArray *matches = [context executeFetchRequest:request error:&error];
        
        if (!matches || error || [matches count]>1) {
            NSAssert(NO, @"the region fetch for name %@ is more than one or not matches", name);
            
        }
        else if (![matches count]) {
            region = [NSEntityDescription insertNewObjectForEntityForName:@"Region" inManagedObjectContext:context];
            region.name = name;
            region.popularity = @1;
//            [region addPhotosObject:photo];
        }
        else {
            //match count is one, find one
            region = [matches lastObject];
            
            int value = [region.popularity intValue] + 1;
            region.popularity = [NSNumber numberWithInt:value];
            
//            NSAssert(![region.photos containsObject:photo], @"region's photos should not contain this photo object, %@", photo );
//            
//            [region addPhotosObject:photo];
        }
    }
    return region;
}
@end
