//
//  Group+Util.h
//  MyApp
//
//  Created by Linwei Ding on 9/23/15.
//  Copyright © 2015 AppsFoundation. All rights reserved.
//
#import <Parse/Parse.h>
#import "Group.h"

@interface Group (Util) 

//@property (nonatomic, retain) id members;

# pragma method -- sever method

+ (Group *)createGroupEntityWithRemoteObject: (RemoteObject *)object
                      inManagedObjectContext: (NSManagedObjectContext *)context;

+ (Group *)groupEntityWithRemoteObject: (RemoteObject *)object
                inManagedObjectContext: (NSManagedObjectContext *)context;

+ (BOOL) deleteGroupEntityWithRemoteObject:(RemoteObject *)object
                    inManagedObjectContext: (NSManagedObjectContext *)context;

+ (Group *)groupEntityWithPFObject: (PFObject *)object
              inManagedObjectContext: (NSManagedObjectContext *)context;

+ (Group *)createGroupEntityWithPFObject: (PFObject *)object
                    inManagedObjectContext: (NSManagedObjectContext *)context;
+ (BOOL) deleteGroupEntityWithPFObject:(PFObject *)object
                 inManagedObjectContext: (NSManagedObjectContext *)context;

#pragma method -- data base method
+ (Group *)createGroupEntity:(NSManagedObjectContext *)context;


//+ (Group *)groupEntitywithChatID:(NSString *)chatID inManagedObjectContext: (NSManagedObjectContext *)context;

//+ (BOOL) deleteGroupEntityWithChatID:(NSString *)chatID inManagedObjectContext: (NSManagedObjectContext *)context;

+ (NSArray *) fetchGroupEntityAll:(NSManagedObjectContext *)context;

+ (void) clearGroupEntityAll:(NSManagedObjectContext *)context;

#pragma method -- other utility methods

- (void) setGroupWithRemoteObject:(RemoteObject *)object inManagedObjectContext: (NSManagedObjectContext *)context  ;

+ (void) setGroup:(Group *)group withPFObject:(PFObject *)object inManagedObjectContext: (NSManagedObjectContext *)context;

+ (Group *) latestGroupEntity:(NSManagedObjectContext *)context;

@end
