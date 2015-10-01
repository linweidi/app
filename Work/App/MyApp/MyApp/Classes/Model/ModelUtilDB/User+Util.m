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
#import "Thumbnail+Util.h"
#import "User+Util.h"

@implementation User (Util)

///TODO store an array of existed user id

- (BOOL) isEqual: (User *)user {
    return [self.globalID isEqualToString:user.globalID];
}

+ (User *) userEntityWithPFUser:(PFUser *)object inManagedObjectContext: (NSManagedObjectContext *)context updateUser:(BOOL)updateUser{
    
    User * user = nil;
    
    NSAssert(object, @"input is nil");
    
    if (object) {
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:PF_USER_CLASS_NAME] ;
        request.predicate = [NSPredicate predicateWithFormat:@"globalID = %@", object.objectId];
        NSError *error;
        NSArray *matches = [context executeFetchRequest:request error:&error   ];
        
        if (!matches || ([matches count]>1)) {
            NSAssert(NO, @"match count is not unique");
        }
        else if (![matches count]) {
            //create a new one
            user = [NSEntityDescription insertNewObjectForEntityForName:PF_USER_CLASS_NAME inManagedObjectContext:context];
            //set the recent values
            [user setWithPFUser:object inManagedObjectContext:context];
        }
        else {
            user = [matches lastObject];
            // if match, still update the user
            if (updateUser) {
                [user setWithPFUser:object inManagedObjectContext:context];
            }

        }
        
        
    }
    
    return user;
}

- (void) setWithPFUser:(PFUser *)user inManagedObjectContext: (NSManagedObjectContext *)context{

    self.globalID = user[PF_USER_OBJECTID];
    self.twitterID = user[PF_USER_TWITTERID];
    self.username = user[PF_USER_USERNAME];
    
    self.email = user[PF_USER_EMAIL];
    self.emailCopy = user[PF_USER_EMAILCOPY];
    self.facebookID = user[PF_USER_FACEBOOKID];
    self.fullname = user[PF_USER_FULLNAME];
    self.fullnameLower = user[PF_USER_FULLNAME_LOWER];

    //self.picture = user[PF_USER_PASSWORD];
    
    
    // this is a PFFile
    PFFile * filePicture = user[PF_USER_PICTURE];
    self.pictureName = filePicture.name;
    self.pictureURL = filePicture.url;
    
    PFFile * thumbnailPicture = user[PF_USER_THUMBNAIL];
    //self.thumbnail = thumbnailPicture.name;
    [Thumbnail thumbnailEntityWithPFUser:thumbnailPicture withUser:self inManagedObjectContext:context ];

}

@end
