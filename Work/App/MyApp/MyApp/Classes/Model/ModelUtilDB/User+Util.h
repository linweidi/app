//
//  User+Util.h
//  MyApp
//
//  Created by Linwei Ding on 9/23/15.
//  Copyright (c) 2015 AppsFoundation. All rights reserved.
//

#import <Parse/Parse.h>
#import "User.h"

@interface User (Util)

+ (User *) convertFromPFUser:(PFUser *)user;

+ (PFUser * )convertFromUser: (User *)user;

- (PFUser *) convertToPFUser;

- (BOOL) isEqual: (User *)user;

+ (User *) userEntityWithPFUser:(PFUser *)object       inManagedObjectContext: (NSManagedObjectContext *)context;

@end
