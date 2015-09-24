//
//  User+Util.m
//  MyApp
//
//  Created by Linwei Ding on 9/23/15.
//  Copyright (c) 2015 AppsFoundation. All rights reserved.
//


#import <Parse/Parse.h>
#import "Thumbnail.h"
#import "AppConstant.h"
#import "User+Util.h"

@implementation User (Util)


- (BOOL) isEqual: (User *)user {
    return [self.globalID isEqualToString:user.globalID];
}

+ (User *) userEntityWithPFUser:(PFUser *)object inManagedObjectContext: (NSManagedObjectContext *)context {
    
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
            [user setWithPFUser:object inManagedObjectContext:context];
        }
        else {
            user = [matches lastObject];
            
        }
        
        
    }
    
    return user;
}

- (void) setWithPFUser:(PFUser *)user inManagedObjectContext: (NSManagedObjectContext *)context{

    
    self.twitterID = user[PF_USER_TWITTERID];
    self.username = user[PF_USER_USERNAME];
    
    self.email = user[PF_USER_EMAIL];
    self.emailCopy = user[PF_USER_EMAILCOPY];
    self.facebookID = user[PF_USER_FACEBOOKID];
    self.fullname = user[PF_USER_FULLNAME];
    self.fullnameLower = user[PF_USER_FULLNAME_LOWER];
    self.globalID = user[PF_USER_OBJECTID];
    //self.picture = user[PF_USER_PASSWORD];
    
    
    // this is a PFFile
    PFFile * filePicture = user[PF_USER_PICTURE];
    self.pictureName = filePicture.name;
    
    PFFile * thumbnailPicture = user[PF_USER_THUMBNAIL];
    //self.thumbnail = thumbnailPicture.name;
    if (self.thumbnail) {
        
        if (self.thumbnail.name == thumbnailPicture.name ) {
            // do nothing
        }
        else {
            [context deleteObject:self.thumbnail];
            self.thumbnail = nil;
            
            Thumbnail * newThumbNail = [NSEntityDescription insertNewObjectForEntityForName:thumbnailPicture.name inManagedObjectContext:context];
            if (newThumbNail) {
                self.thumbnail = newThumbNail ;
            }
            else {
                NSAssert(NO, @"insert thumbnail fails");
            }
        }
    }
    else {
        // no thumbnail exists
        Thumbnail * newThumbNail = [NSEntityDescription insertNewObjectForEntityForName:thumbnailPicture.name inManagedObjectContext:context];
        if (newThumbNail) {
            self.thumbnail = newThumbNail ;
        }
        else {
            NSAssert(NO, @"insert thumbnail fails");
        }
    }


}

@end
