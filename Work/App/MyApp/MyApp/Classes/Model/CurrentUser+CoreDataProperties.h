//
//  CurrentUser+CoreDataProperties.h
//  MyApp
//
//  Created by Linwei Ding on 9/22/15.
//  Copyright © 2015 AppsFoundation. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//
#import <Parse/Parse.h>

#import "CurrentUser.h"

NS_ASSUME_NONNULL_BEGIN

@interface CurrentUser (CoreDataProperties)


+ (CurrentUser *) getCurrentUser;

+ (PFUser *) convertFromCurrentUser: (CurrentUser *)currentUser;

@end

NS_ASSUME_NONNULL_END
