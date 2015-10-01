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

#import "AppHeader.h"

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

+ (User *) createUserEntity:(NSManagedObjectContext *)context{
    
    User * user = nil;
    

    //create a new one
    user = [NSEntityDescription insertNewObjectForEntityForName:PF_USER_CLASS_NAME inManagedObjectContext:context];
    
    return user;
}


- (void) setWithPFUser:(PFUser *)user inManagedObjectContext: (NSManagedObjectContext *)context{

    self.globalID = user[PF_USER_OBJECTID];

    self.username = user[PF_USER_USERNAME];
    self.password = user[PF_USER_PASSWORD];
    
    self.email = user[PF_USER_EMAIL];
    self.emailCopy = user[PF_USER_EMAILCOPY];

    self.fullname = user[PF_USER_FULLNAME];
    self.fullnameLower = user[PF_USER_FULLNAME_LOWER];

    self.facebookID = user[PF_USER_FACEBOOKID];
    self.twitterID = user[PF_USER_TWITTERID];
    

    PFFile * filePicture = user[PF_USER_PICTURE];
    self.pictureName = filePicture.name;
    self.pictureURL = filePicture.url;
    
    PFFile * thumbnailPicture = user[PF_USER_THUMBNAIL];
    //self.thumbnail = thumbnailPicture.name;
    Thumbnail * thumb =[Thumbnail thumbnailEntityWithPFUser:thumbnailPicture withUser:self inManagedObjectContext:context ];
    self.thumbnail = thumb;
    //if create, add user to User Manager
    [[UserManager sharedUtil] addUser:self];
}

+ (User *) convertFromPFUser:(PFUser *)user inManagedObjectContext:(NSManagedObjectContext *) context{
    User * userEntity = nil;
    
    UserManager * manager = [UserManager sharedUtil];
    if ([manager exists:user[PF_USER_OBJECTID]]) {
        userEntity = [manager getUser:user[PF_USER_OBJECTID]];
    }
    else {
        // not exist
        userEntity = [User createUserEntity:context];
        [userEntity setWithPFUser:user inManagedObjectContext:context];
    }
    
    return userEntity;
}

+ (User *) convertFromRemoteUser:(RemoteUser *)user inManagedObjectContext:(NSManagedObjectContext *) context {
    User * userEntity = nil;
    
    userEntity = [User convertFromPFUser:user inManagedObjectContext:context];
    
    return userEntity;
}


- (PFUser *) convertToPFUser {
    PFUser * user = [PFUser user];

    
    user[PF_USER_OBJECTID] = self.globalID ;
 
    user[PF_USER_USERNAME] = self.username;
    user[PF_USER_PASSWORD] = self.password ;
    
    user[PF_USER_EMAIL] = self.email ;
    user[PF_USER_EMAILCOPY] = self.emailCopy ;

    user[PF_USER_FULLNAME] = self.fullname ;
    user[PF_USER_FULLNAME_LOWER] = self.fullnameLower ;
    
    user[PF_USER_FACEBOOKID] = self.facebookID ;
    user[PF_USER_TWITTERID] = self.twitterID ;
    
    
    // this is a PFFile
    PFFile * filePicture = [PFFile fileWithName:self.pictureName contentsAtPath:self.pictureURL];
    user[PF_USER_PICTURE] = filePicture;
    
    PFFile * thumbnailPicture = [PFFile fileWithName:self.thumbnail.name contentsAtPath:self.thumbnail.url];
    user[PF_USER_THUMBNAIL] = thumbnailPicture;
    
    return user;
}

- (RemoteUser *) convertToRemoteUser {
    RemoteUser * user = nil;
    
    user = [self convertToPFUser];
    
    return user;
}


@end
