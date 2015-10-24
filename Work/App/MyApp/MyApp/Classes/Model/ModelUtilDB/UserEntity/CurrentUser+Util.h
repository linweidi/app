//
//  CurrentUser+Util.h
//  MyApp
//
//  Created by Linwei Ding on 9/23/15.
//  Copyright (c) 2015 AppsFoundation. All rights reserved.
//
#import <Parse/Parse.h>
#import "AppHeader.h"
#import "CurrentUser.h"


@interface CurrentUser (Util) 

#define ENTITY_UTIL_TEMPLATE_CLASS CurrentUser
#define ENTITY_UTIL_TEMPLATE_CLASS_NAME @"CurrentUser"

#include "../Template/EntityUtilTemplate.hh"

+ (CurrentUser *) getCurrentUser;
//
//+ (RemoteUser *)convertFromCurrentUser:(CurrentUser *)currentUser;
//
//- (RemoteUser *) convertToRemoteUser;

+ (CurrentUser *) createCurrentUserEntity:(NSManagedObjectContext *)context;

+ (CurrentUser *) fetchCurrentUserEntityWithUserID:(NSString *)userID inManagedObjectContext:(NSManagedObjectContext *)context;

+ (CurrentUser *) fetchCurrentUserEntityWithUsername:(NSString *)username inManagedObjectContext:(NSManagedObjectContext *)context;

- (void) setWithRemoteUser:(RemoteUser *)user inManagedObjectContext: (NSManagedObjectContext *)context
@end
