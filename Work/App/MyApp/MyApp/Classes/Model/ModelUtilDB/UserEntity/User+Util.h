//
//  User+Util.h
//  MyApp
//
//  Created by Linwei Ding on 9/23/15.
//  Copyright (c) 2015 AppsFoundation. All rights reserved.
//

#import <Parse/Parse.h>
#import <Foundation/Foundation.h>
#import "RemoteHeader.h"
#import "User.h"


@interface User (Util)

#undef ENTITY_UTIL_TEMPLATE_CLASS
#undef ENTITY_UTIL_TEMPLATE_CLASS_NAME
#define ENTITY_UTIL_TEMPLATE_CLASS User
#define ENTITY_UTIL_TEMPLATE_CLASS_NAME @"User"

#include "../Template/EntityUtilTemplate.hh"


- (BOOL) isEqualToUser: (User *)user;

+ (ENTITY_UTIL_TEMPLATE_CLASS *)fetchEntityWithUsername:(NSString *)username inManagedObjectContext:  (NSManagedObjectContext *)context;

//- (RemoteUser *) convertToRemoteUser;
//
//- (PFUser *) convertToPFUser;
//
//+ (User *) convertFromPFUser:(PFUser *)user inManagedObjectContext:(NSManagedObjectContext *) context;
//
//+ (RemoteUser *) convertToRemoteUser:(User *)user;
//
//+ (NSArray *) convertFromRemoteUserArray:(NSArray *)users inManagedObjectContext:(NSManagedObjectContext *) context;
//
//+ (User *) convertFromRemoteUser:(RemoteUser *)user inManagedObjectContext:(NSManagedObjectContext *) context;
//
//
///*  legacy
//+ (User *) userEntityWithPFUser:(PFUser *)object inManagedObjectContext: (NSManagedObjectContext *)context updateUser:(BOOL)updateUser;
//*/
//+ (User *) createUserEntity:(NSManagedObjectContext *)context;
//
//- (void) setWithPFUser:(PFUser *)user inManagedObjectContext: (NSManagedObjectContext *)context;


@end
