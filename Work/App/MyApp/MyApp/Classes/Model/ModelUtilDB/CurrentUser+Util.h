//
//  CurrentUser+Util.h
//  MyApp
//
//  Created by Linwei Ding on 9/23/15.
//  Copyright (c) 2015 AppsFoundation. All rights reserved.
//
#import <Parse/Parse.h>

#import "CurrentUser.h"

@interface CurrentUser (Util)


+ (CurrentUser *) getCurrentUser;

+ (PFUser *)convertFromCurrentUser:(CurrentUser *)currentUser;

@end
