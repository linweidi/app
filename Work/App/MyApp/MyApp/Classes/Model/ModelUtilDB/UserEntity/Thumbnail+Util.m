//
//  Thumbnail+Util.m
//  MyApp
//
//  Created by Linwei Ding on 9/23/15.
//  Copyright © 2015 AppsFoundation. All rights reserved.
//
#import <Parse/Parse.h>
#import "User.h"
#import "UserManager.h"
#import "Thumbnail+Util.h"

@implementation Thumbnail (Util)

#undef ENTITY_UTIL_TEMPLATE_CLASS
#undef ENTITY_UTIL_TEMPLATE_CLASS_NAME
#define ENTITY_UTIL_TEMPLATE_CLASS Thumbnail
#define ENTITY_UTIL_TEMPLATE_CLASS_NAME @"Thumbnail"

#include "../Template/EntityUtilTemplate.mh"

+ (Thumbnail *) thumbnailEntityWithPFUser:(PFFile *)thumbFile withUserID:(NSString *)userID inManagedObjectContext: (NSManagedObjectContext *)context {
    UserManager * manager = [UserManager sharedUtil];

    
    
    PFFile * thumbnailPicture = thumbFile;

    
    Thumbnail *thumbObj = nil   ;
    NSString * thumbName = nil;
    UserContext * userContext = nil;
    User * user = nil;
    if ([manager exists:userID]) {
        //thumb exists in core data
        userContext = [manager getContext:userID];
        user = userContext.user;
        thumbObj = userContext.thumb;
        thumbName = userContext.thumbName;
        
        if (thumbName == thumbnailPicture.name ) {
            //thumbnail already exists
            // do nothing
        }
        else {
            //thumbnail different, so update
            [context deleteObject: thumbObj];
            user.thumbnail = nil;
            userContext.thumb = nil;
            
            thumbObj = [NSEntityDescription insertNewObjectForEntityForName:thumbnailPicture.name inManagedObjectContext:context];
            if (thumbObj) {
                
                //populate thumb's values
                [thumbObj setThumbnailByPFFile:thumbnailPicture];
                
                //update user 's link
                user.thumbnail = thumbObj ;
                
                //update user manager's link
                userContext.thumbName = thumbnailPicture.name;
                userContext.thumb = thumbObj;
                

            }
            else {
                NSAssert(NO, @"insert thumbnail fails");
            }
        }
    }
    else {
        // thumbnail is not initialized
        // no thumbnail exists, no user exists
        thumbObj = [NSEntityDescription insertNewObjectForEntityForName:thumbnailPicture.name inManagedObjectContext:context];
        if (thumbObj) {
            [thumbObj setThumbnailByPFFile:thumbnailPicture];
        }
        else {
            NSAssert(NO, @"insert thumbnail fails");
        }
    }
    
    return thumbObj;
}

- (void) setThumbnailByPFFile:(PFFile *)thumb {
    self.name = thumb.name;
    self.url = thumb.url;
    
    [thumb getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
        if (!error) {
            self.data = data;
        }
    }];
}

+ (ENTITY_UTIL_TEMPLATE_CLASS *)fetchEntityWithFileName:(NSString *)fileName inManagedObjectContext:  (NSManagedObjectContext *)context {
    ENTITY_UTIL_TEMPLATE_CLASS * object = nil;
    
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:ENTITY_UTIL_TEMPLATE_CLASS_NAME] ;
    request.predicate = [NSPredicate predicateWithFormat:@"fileName = %@", fileName];
    NSError *error;
    NSArray *matches = [context executeFetchRequest:request error:&error   ];
    
    if (!matches || ([matches count]>1)) {
        NSAssert(NO, @"match count is not unique");
    }
    else if (![matches count]) {
        //create a new one
        object = nil;
        
    }
    else {
        object = [matches lastObject];
    }
    
    return object;
    
}
/*
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
            newThumbNail
        }
        else {
            newThumbNail = [matches lastObject];
            
        }
        
        
    }
 
    return newThumbNail;
}
*/

@end
