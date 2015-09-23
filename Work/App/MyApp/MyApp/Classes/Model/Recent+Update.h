//
//  Recent+Update.h
//  MyApp
//
//  Created by Linwei Ding on 9/22/15.
//  Copyright (c) 2015 AppsFoundation. All rights reserved.
//
#import <Parse/Parse.h>
#import "Recent.h"

@interface Recent (Update)

+ (Recent *)recentWithPFObject: (PFObject *)object
      inManagedObjectContext: (NSManagedObjectContext *)context;

@end
