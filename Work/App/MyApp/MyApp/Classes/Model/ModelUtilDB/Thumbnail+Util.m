//
//  Thumbnail+Util.m
//  MyApp
//
//  Created by Linwei Ding on 9/23/15.
//  Copyright © 2015 AppsFoundation. All rights reserved.
//

#import "Thumbnail+Util.h"

@implementation Thumbnail (Util)

+ (Thumbnail *) thumbnailEntityWithPFUser:(PFFile *)file inManagedObjectContext: (NSManagedObjectContext *)context {
    
    User * user = nil;
    
    NSAssert(object, @"input is nil");
    
    if (object) {
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"User"] ;
        request.predicate = [NSPredicate predicateWithFormat:@"globalID = %@", object.objectId];
        NSError *error;
        NSArray *matches = [context executeFetchRequest:request error:&error   ];
        
        if (!matches || ([matches count]>1)) {
            NSAssert(NO, @"match count is not unique");
        }
        else if (![matches count]) {
            //create a new one
            user = [NSEntityDescription insertNewObjectForEntityForName:@"User" inManagedObjectContext:context];
            //set the recent values
            [user setWithPFUser:object];
        }
        else {
            recent = [matches lastObject];
            
        }
        
        
    }
    
    return recent;
}

+ (Thumbnail *) thumbnailEntity:(NSData *)data inManagedObjectContext: (NSManagedObjectContext *)context {
    
}

@end
