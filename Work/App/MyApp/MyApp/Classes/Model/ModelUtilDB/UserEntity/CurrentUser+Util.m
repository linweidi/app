//
//  CurrentUser+Util.m
//  MyApp
//
//  Created by Linwei Ding on 9/23/15.
//  Copyright (c) 2015 AppsFoundation. All rights reserved.
//
#import "AppHeader.h"
#import <Parse/Parse.h>

#import "Thumbnail.h"
#import "AppConstant.h"

#import "AppHeader.h"

#import "ConfigurationManager.h"
#import "Thumbnail+Util.h"
#import "User+Util.h"

#import "CurrentUser+Util.h"


@implementation CurrentUser (Util)

- (BOOL) isEqual: (CurrentUser *)user {
    return [self.globalID isEqualToString:user.globalID];
}

/* legacy
+ (CurrentUser *) userEntityWithPFUser:(PFUser *)object inManagedObjectContext: (NSManagedObjectContext *)context updateUser:(BOOL)updateUser{
    
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
 */
- (void) setWithRemoteUser:(RemoteUser *)user inManagedObjectContext: (NSManagedObjectContext *)context{
    
    [self setWithRemoteUser:user inManagedObjectContext:context];
}

+ (NSArray *) fetchAllCurrentUserEntities:(NSManagedObjectContext *)context {
    return nil;
}

+ (CurrentUser *) fetchCurrentUserEntityWithUserID:(NSString *)userID inManagedObjectContext:(NSManagedObjectContext *)context {
    
    CurrentUser * user = nil;
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:PF_CURRENT_USER_CLASS_NAME] ;
    request.predicate = [NSPredicate predicateWithFormat:@"globalID = %@", userID];
    NSError *error;
    NSArray *matches = [context executeFetchRequest:request error:&error   ];
    
    if (!matches || ([matches count]>1)) {
        NSAssert(NO, @"match count is not unique");
    }
    else if (![matches count]) {
        //create a new one
        user = nil;
    }
    else {
        user = [matches lastObject];
        
    }
    
    return user;
}

+ (CurrentUser *) fetchCurrentUserEntityWithUsername:(NSString *)username inManagedObjectContext:(NSManagedObjectContext *)context {
    
    CurrentUser * user = nil;
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:PF_CURRENT_USER_CLASS_NAME] ;
    request.predicate = [NSPredicate predicateWithFormat:@"username = %@", username];
    NSError *error;
    NSArray *matches = [context executeFetchRequest:request error:&error   ];
    
    if (!matches || ([matches count]>1)) {
        NSAssert(NO, @"match count is not unique");
    }
    else if (![matches count]) {
        //create a new one
        user = nil;
    }
    else {
        user = [matches lastObject];
        
    }
    
    return user;
}

+ (CurrentUser *) createCurrentUserEntity:(NSManagedObjectContext *)context{
    
    CurrentUser * user = nil;
    
    
    //create a new one
    user = [NSEntityDescription insertNewObjectForEntityForName:PF_USER_CLASS_NAME inManagedObjectContext:context];
    
    return user;
}

/// legacy code, TODO remove this
+ (CurrentUser *) getCurrentUser {
    ConfigurationManager *manager = [ConfigurationManager sharedManager];
    return [manager getCurrentUser];
}



@end
