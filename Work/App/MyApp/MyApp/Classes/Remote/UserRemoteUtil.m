//
//  UserRemoteUtil.m
//  MyApp
//
//  Created by Linwei Ding on 9/30/15.
//  Copyright (c) 2015 AppsFoundation. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>
//#import "NavigationController.h"
#import "RemoteHeader.h"

#import "AppConstant.h"
#import "CurrentUser+Util.h"
#import "Thumbnail+Util.h"
#import "User+Util.h"
#import "ConfigurationManager.h"
#import "push.h"
#import "UserRemoteUtil.h"

@implementation UserRemoteUtil


+ (UserRemoteUtil *)sharedUtil {
    static dispatch_once_t predicate = 0;
    static UserRemoteUtil *sharedObject;
    
    dispatch_once(&predicate, ^{
        //initializing singleton object
        sharedObject = [[self alloc] init];
        
        sharedObject.className = PF_USER_CLASS_NAME;
        
    });
    return sharedObject;
}

- (void) setCommonObject:(BASE_REMOTE_UTIL_OBJ_TYPE)object withRemoteObject:(RemoteObject *)remoteObj inManagedObjectContext: (NSManagedObjectContext *)context{
    NSAssert([object isKindOfClass:[User class]], @"Type casting is wrong");
    User * user = (User *)object;
    user.username = remoteObj[PF_USER_USERNAME];
    user.password = remoteObj[PF_USER_PASSWORD];
    
    user.email = remoteObj[PF_USER_EMAIL];
    user.emailCopy = remoteObj[PF_USER_EMAILCOPY];
    
    user.fullname = remoteObj[PF_USER_FULLNAME];
    user.fullnameLower = remoteObj[PF_USER_FULLNAME_LOWER];
    
    user.facebookID = remoteObj[PF_USER_FACEBOOKID];
    user.twitterID = remoteObj[PF_USER_TWITTERID];

}

- (void) setCommonRemoteObject:(RemoteObject *)remoteObj withObject:(BASE_REMOTE_UTIL_OBJ_TYPE)object {
    NSAssert([object isKindOfClass:[User class]], @"Type casting is wrong");
    User * user = (User *)object;
    remoteObj[PF_USER_USERNAME] = user.username;
    remoteObj[PF_USER_PASSWORD] = user.password ;
    
    remoteObj[PF_USER_EMAIL] = user.email ;
    remoteObj[PF_USER_EMAILCOPY] = user.emailCopy ;
    
    remoteObj[PF_USER_FULLNAME] = user.fullname ;
    remoteObj[PF_USER_FULLNAME_LOWER] = user.fullnameLower ;
    
    remoteObj[PF_USER_FACEBOOKID] = user.facebookID ;
    remoteObj[PF_USER_TWITTERID] = user.twitterID ;
}

- (void)setNewRemoteObject:(RemoteObject *)remoteObj withObject:(UserEntity *)object {
    [super setNewRemoteObject:remoteObj withObject:object];
    NSAssert([object isKindOfClass:[User class]], @"Type casting is wrong");
    User * user = (User *)object;
    
    // this is a PFFile
    PFFile * filePicture = [PFFile fileWithName:user.pictureName contentsAtPath:user.pictureURL];
    remoteObj[PF_USER_PICTURE] = filePicture;
    
    PFFile * thumbnailPicture = [PFFile fileWithName:user.thumbnail.name contentsAtPath:user.thumbnail.url];
    remoteObj[PF_USER_THUMBNAIL] = thumbnailPicture;
}

- (void)setExistedRemoteObject:(RemoteObject *)remoteObj withObject:(UserEntity *)object {
    [super setExistedRemoteObject:remoteObj withObject:object ];
    NSAssert([object isKindOfClass:[User class]], @"Type casting is wrong");
    User * user = (User *)object;
    
    // this is a PFFile
    PFFile * filePicture = [PFFile fileWithName:user.pictureName contentsAtPath:user.pictureURL];
    remoteObj[PF_USER_PICTURE] = filePicture;
    
    PFFile * thumbnailPicture = [PFFile fileWithName:user.thumbnail.name contentsAtPath:user.thumbnail.url];
    remoteObj[PF_USER_THUMBNAIL] = thumbnailPicture;
    
}

- (void)setNewObject:(UserEntity *)object withRemoteObject:(RemoteObject *)remoteObj inManagedObjectContext:(NSManagedObjectContext *)context {
    [super setNewObject:object withRemoteObject:remoteObj inManagedObjectContext:context];
    NSAssert([object isKindOfClass:[User class]], @"Type casting is wrong");
    User * user = (User *)object;
    
    PFFile * filePicture = remoteObj[PF_USER_PICTURE];
    user.pictureName = filePicture.name;
    user.pictureURL = filePicture.url;
    
    PFFile * thumbnailPicture = remoteObj[PF_USER_THUMBNAIL];
    //self.thumbnail = thumbnailPicture.name;
    Thumbnail * thumb =
    
    [Thumbnail thumbnailEntityWithPFUser:thumbnailPicture withUserID:remoteObj.objectId inManagedObjectContext:context ];
    user.thumbnail = thumb;
    
    //if create, add user to User Manager
    [[UserManager sharedUtil] addUser:user];
}

- (void)setExistedObject:(UserEntity *)object withRemoteObject:(RemoteObject *)remoteObj inManagedObjectContext:(NSManagedObjectContext *)context {
    [super setExistedObject:object withRemoteObject:remoteObj inManagedObjectContext:context];
    NSAssert([object isKindOfClass:[User class]], @"Type casting is wrong");
    User * user = (User *)object;
    
    PFFile * filePicture = remoteObj[PF_USER_PICTURE];
    user.pictureName = filePicture.name;
    user.pictureURL = filePicture.url;
    
    PFFile * thumbnailPicture = remoteObj[PF_USER_THUMBNAIL];
    //self.thumbnail = thumbnailPicture.name;
    Thumbnail * thumb =
    
    [Thumbnail thumbnailEntityWithPFUser:thumbnailPicture withUserID:remoteObj.objectId inManagedObjectContext:context ];
    user.thumbnail = thumb;
}


- (User *) convertToUser:(RemoteUser *)user {
    User * userEntity = nil;
    
    UserManager * manager = [UserManager sharedUtil];
    if ([manager exists:user[PF_USER_OBJECTID]]) {
        userEntity = [manager getUser:user[PF_USER_OBJECTID]];
    }
    else {
        // not exist
        userEntity = [User createEntity:self.managedObjectContext];
        [self setNewObject:userEntity withRemoteObject:user inManagedObjectContext:self.managedObjectContext];
        [manager addUser:userEntity];
    }
    
    return userEntity;
}


- (RemoteUser *) convertToRemoteUser:(User *)user {
    RemoteUser * userRT = [PFUser user];
    
    if ([user.globalID length]) {
        //existed remote object
        //[self setExistedRemoteObject:userRT withObject:user];
        userRT.objectId = user.globalID;
    }
    else {
        // new remote object
        [self setNewRemoteObject:userRT withObject:user];
    }
    
    
    return userRT;
}

- (NSArray *) convertToUserArray:(NSArray *)users {
    NSAssert(!users, @"input is nil;");
    NSMutableArray * userArray = [[NSMutableArray alloc] init];
    
    for (PFUser * userPF in users) {
        User * user = [self convertToUser:userPF inManagedObjectContext:self.managedObjectContext];
        [userArray addObject:user];
    }
    
    return userArray;
}

- (void) loadUserFromParse:(NSString *)userId completionHandler:(REMOTE_OBJECT_BLOCK)block {
    NSAssert(userId, @"userId is nil") ;
    UserManager * manager = [UserManager sharedUtil];
    
    
    BOOL existed = [manager exists:userId];
    
    if (existed) {
        User * user = [manager getUser:userId];
        [self downloadUpdateObject:user completionHandler:block];
    }
    else {
        [self downloadCreateObject:userId completionHandler:block];
    }

}

- (void) loadRemoteUser:(NSString *)userId completionHandler:(REMOTE_OBJECT_BLOCK)block  {
    [self loadUserFromParse:userId completionHandler:block];
}

- (void) loadRemoteUsers:(NSArray *)userIDs completionHandler:(REMOTE_ARRAY_BLOCK)block  {
    PFQuery *query = [PFUser query];
	[query whereKey:PF_USER_OBJECTID containedIn:userIDs];
	[query orderByAscending:PF_USER_FULLNAME];
	[query setLimit:EVENTVIEW_ITEM_NUM];
	[query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        NSArray * userObjArray = [[UserRemoteUtil sharedUtil] convertToUserArray:objects inManagedObjectContext:self.managedObjectContext];
        //        for (PFUser * object in objects) {
        //
        //        }
        block(userObjArray, error);
    }];
    
}

//- (void) logInUser:(id)target  {
//   	NavigationController *navigationController = [[NavigationController alloc] initWithRootViewController:[[WelcomeView alloc] init]];
//    navigationController.hidesBottomBarWhenPushed = YES;
//	[target presentViewController:navigationController animated:YES completion:nil];
//}

- (BOOL) existUsername: (NSString *) userID {
    BOOL ret = NO;
    
    NSAssert([userID length]!=0 , @"not valid userId");
    
    return ret;
}

- (void) signUp:(CurrentUser *)user completionHandler:(REMOTE_BOOL_BLOCK)block {

    PFUser * userRT = [[UserRemoteUtil sharedUtil] convertToRemoteUser:user];
    ConfigurationManager * config = [ConfigurationManager sharedManager];
    
    // here, it will check if the username and email has already existed
    [userRT signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            // update the isLogggedIn
            
            
            // remote create the local current user
            CurrentUser * currentUser = [CurrentUser createEntity:config.managedObjectContext];
            // update current user and add inot user manager
            [[UserRemoteUtil sharedUtil] setNewObject:currentUser withRemoteObject:userRT inManagedObjectContext:config.managedObjectContext];
            

            
            if (currentUser) {
                // populate the current user to configuration manager
                config.currentUserID = currentUser.globalID;
                [config setCurrentUser:currentUser];
                
                ParsePushUserAssign();
                [ProgressHUD showSuccess:[NSString stringWithFormat:@"Welcome back %@!", user.fullname]];
                
                block(succeeded, error);
                
                config.isLoggedIn = YES;
            }

        }
        else {
            [ProgressHUD showError:@"sign up failes"];
        }
    }];
}

- (void)logInWithUsername: (NSString *)username password:(NSString *)password completionHandler:(REMOTE_BOOL_BLOCK)block {
    
    ConfigurationManager * config = [ConfigurationManager sharedManager];
    
    [PFUser logInWithUsernameInBackground:username password:password block:^(PFUser *user, NSError *error)
     {
         if (user != nil)
         {

             
             CurrentUser * currentUser = nil;
             
             // remote create the local current user
             currentUser  = [CurrentUser entityWithUsername:username inManagedObjectContext:config.managedObjectContext];
             if (!currentUser) {
                 currentUser = [CurrentUser createEntity:config.managedObjectContext];
                 // update current user and add inot user manager
                 
                 
                 [[UserRemoteUtil sharedUtil] setNewObject:currentUser withRemoteObject:user inManagedObjectContext:config.managedObjectContext];
             }
             
             
             if (currentUser) {
                 // populate the current user to configuration manager
                 config.currentUserID = currentUser.globalID;
                 [config setCurrentUser:currentUser];
                 
                 ParsePushUserAssign();
                 [ProgressHUD showSuccess:[NSString stringWithFormat:@"Welcome back %@!", user[PF_USER_FULLNAME]]];
                 
                 block(YES, error);
                 
                 // update the isLogggedIn
                 config.isLoggedIn = YES;
             }
         }
         else [ProgressHUD showError:error.userInfo[@"error"]];
     }];
}

- (void) logOut {
    ConfigurationManager * config = [ConfigurationManager sharedManager];
    [config clearCurrentUserContext];
    [PFUser logOut];
}

//- (void) populateCurrentUserEntity:(CurrentUser *)currentUser fromUser:(CurrentUser *)user {
//
//    currentUser.username = user.username;
//    currentUser.password = user.password;
//    currentUser.email = user.email;
//    
//    currentUser.emailCopy = user.email;
//    currentUser.fullname = user.username;
//    currentUser.fullnameLower = [user.username lowercaseString];
//}

//+ (RemoteUser *) convertFromCurrentUser: (CurrentUser *)currentUser {
//    RemoteUser * user = [User convertToRemoteUser:currentUser];
//    // more specific for CurrentUser of Remote
//    return user;
//}
//- (RemoteUser *) convertToRemoteUser {
//    return [self convertToPFUser];
//}
//
//- (PFUser *) convertToPFUser {
//    RemoteUser * user = [self convertToPFUser];
//    return user;
//}
@end
