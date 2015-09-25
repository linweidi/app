//
//  Thumbnail+Util.m
//  MyApp
//
//  Created by Linwei Ding on 9/23/15.
//  Copyright © 2015 AppsFoundation. All rights reserved.
//
#import <Parse/Parse.h>
#import "User.h"
#import "Thumbnail+Util.h"

@implementation Thumbnail (Util)

+ (Thumbnail *) thumbnailEntityWithPFUser:(PFFile *)thumbFile withUser:(User *)user inManagedObjectContext: (NSManagedObjectContext *)context {


    
    
    PFFile * thumbnailPicture = thumbFile;
    //self.thumbnail = thumbnailPicture.name;
    
    Thumbnail *newThumbNail = nil   ;
    if ([user thumbnail]) {
        
        if (user.thumbnail.name == thumbnailPicture.name ) {
            //thumbnail already exists
            // do nothing
        }
        else {
            //thumbnail different
            [context deleteObject:user.thumbnail];
            user.thumbnail = nil;
            
            newThumbNail = [NSEntityDescription insertNewObjectForEntityForName:thumbnailPicture.name inManagedObjectContext:context];
            if (newThumbNail) {
                newThumbNail.name = thumbnailPicture.name;
                
                [thumbnailPicture getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
                    if (!error) {
                        newThumbNail.data = data;
                    }
                }];
                
                user.thumbnail = newThumbNail ;
            }
            else {
                NSAssert(NO, @"insert thumbnail fails");
            }
        }
    }
    else {
        // thumbnail is not initialized
        // no thumbnail exists
        newThumbNail = [NSEntityDescription insertNewObjectForEntityForName:thumbnailPicture.name inManagedObjectContext:context];
        if (newThumbNail) {
            newThumbNail.name = thumbnailPicture.name;
            
            [thumbnailPicture getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
                if (!error) {
                    newThumbNail.data = data;
                }
            }];
            
            user.thumbnail = newThumbNail ;
        }
        else {
            NSAssert(NO, @"insert thumbnail fails");
        }
    }
    
    return newThumbNail;
}

+ (Thumbnail *) thumbnailEntity:(NSString *)name inManagedObjectContext: (NSManagedObjectContext *)context {
    Thumbnail *newThumbNail = nil   ;


    NSAssert(name, @"input is nil");

    if (name) {
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Thumbnail"] ;
        request.predicate = [NSPredicate predicateWithFormat:@"name = %@", name];
        NSError *error;
        NSArray *matches = [context executeFetchRequest:request error:&error   ];

        if (!matches || ([matches count]>1)) {
            NSAssert(NO, @"match count is not unique");
        }
        else if (![matches count]) {
            //create a new one
            newThumbNail = [NSEntityDescription insertNewObjectForEntityForName:@"Thumbnail" inManagedObjectContext:context];
            //set the recent values
            newThumbNail.name = name;
        }
        else {
            newThumbNail = [matches lastObject];
            
        }
        
        
    }
    
    return newThumbNail;
}

@end
