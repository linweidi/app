//
//  People+Util.h
//  MyApp
//
//  Created by Linwei Ding on 10/1/15.
//  Copyright (c) 2015 AppsFoundation. All rights reserved.
//

#import "People.h"

@interface People (Util)

# pragma method -- sever method

+ (People *)createPeopleEntityWithRemoteObject: (RemoteObject *)object
                      inManagedObjectContext: (NSManagedObjectContext *)context;

+ (People *)peopleEntityWithRemoteObject: (RemoteObject *)object
                inManagedObjectContext: (NSManagedObjectContext *)context;

+ (BOOL) deletePeopleEntityWithRemoteObject:(RemoteObject *)object
                    inManagedObjectContext: (NSManagedObjectContext *)context;

+ (People *)peopleEntityWithPFObject: (PFObject *)object
            inManagedObjectContext: (NSManagedObjectContext *)context;

+ (People *)createPeopleEntityWithPFObject: (PFObject *)object
                  inManagedObjectContext: (NSManagedObjectContext *)context;
+ (BOOL) deletePeopleEntityWithPFObject:(PFObject *)object
                inManagedObjectContext: (NSManagedObjectContext *)context;

#pragma method -- data base method
+ (People *)createPeopleEntity:(NSManagedObjectContext *)context;


//+ (People *)peopleEntitywithChatID:(NSString *)chatID inManagedObjectContext: (NSManagedObjectContext *)context;

//+ (BOOL) deletePeopleEntityWithChatID:(NSString *)chatID inManagedObjectContext: (NSManagedObjectContext *)context;

+ (NSArray *) fetchPeopleEntityAll:(NSManagedObjectContext *)context;

+ (void) clearPeopleEntityAll:(NSManagedObjectContext *)context;

#pragma method -- other utility methods

- (void) setPeopleWithRemoteObject:(RemoteObject *)object inManagedObjectContext: (NSManagedObjectContext *)context  ;

+ (void) setPeople:(People *)people withPFObject:(PFObject *)object inManagedObjectContext: (NSManagedObjectContext *)context;

+ (People *) latestPeopleEntity:(NSManagedObjectContext *)context;


@end
