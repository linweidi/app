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

// PFObject's method
# pragma method -- sever method
+ (Recent *)recentEntityWithPFObject: (PFObject *)object
      inManagedObjectContext: (NSManagedObjectContext *)context;

+ (Recent *)createRecentEntityWithPFObject: (PFObject *)object
                    inManagedObjectContext: (NSManagedObjectContext *)context;
+ (BOOL) deleteRecentEntityWithPFObject:(PFObject *)object
                 inManagedObjectContext: (NSManagedObjectContext *)context;

#pragma method -- data base method
+ (NSArray *) fetchRecentEntityAll:(NSManagedObjectContext *)context;

+ (void) clearRecentEntityAll:(NSManagedObjectContext *)context;

+ (Recent *) latestRecentEntity:(NSManagedObjectContext *)context;

@end
