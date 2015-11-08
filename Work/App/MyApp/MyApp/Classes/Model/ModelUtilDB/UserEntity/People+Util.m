//
//  People+Util.m
//  MyApp
//
//  Created by Linwei Ding on 10/1/15.
//  Copyright (c) 2015 AppsFoundation. All rights reserved.
//
#import "AppHeader.h"
#import "User+Util.h"

#import "CurrentUser+Util.h"
#import "People+Util.h"


@implementation People (Util)

#undef ENTITY_UTIL_TEMPLATE_CLASS
#undef ENTITY_UTIL_TEMPLATE_CLASS_NAME
#define ENTITY_UTIL_TEMPLATE_CLASS People
#define ENTITY_UTIL_TEMPLATE_CLASS_NAME @"People"

#include "../Template/EntityUtilTemplate.mh"

//+ (People *)createPeopleEntityWithPFObject: (PFObject *)object
//                  inManagedObjectContext: (NSManagedObjectContext *)context {
//    People * people = nil;
//    
//    NSAssert(object, @"input is nil");
//    
//    //create a new one
//    people = [NSEntityDescription insertNewObjectForEntityForName:PF_PEOPLE_CLASS_NAME
//                                          inManagedObjectContext:context];
//    //set the people values
//    [people setPeopleWithPFObject:object inManagedObjectContext:context];
//    
//    
//    return people;
//}
//
//+ (People *)createPeopleEntityWithRemoteObject: (RemoteObject *)object
//                      inManagedObjectContext: (NSManagedObjectContext *)context {
//    return [ People createPeopleEntityWithPFObject:object inManagedObjectContext:context];
//}
//
//+ (People *)peopleEntityWithPFObject: (PFObject *)object
//            inManagedObjectContext: (NSManagedObjectContext *)context {
//    People * people = nil;
//    
//    NSAssert(object, @"input is nil");
//    
//    if (object) {
//        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:PF_PEOPLE_CLASS_NAME] ;
//        request.predicate = [NSPredicate predicateWithFormat:@"globalID = %@", object[PF_PEOPLE_OBJECTID]];
//        NSError *error;
//        NSArray *matches = [context executeFetchRequest:request error:&error   ];
//        
//        if (!matches || ([matches count]>1)) {
//            NSAssert(NO, @"match count is not unique");
//        }
//        else if (![matches count]) {
//            //create a new one
//            people = [NSEntityDescription insertNewObjectForEntityForName:PF_PEOPLE_CLASS_NAME inManagedObjectContext:context];
//            //set the people values
//            [people setPeopleWithPFObject:object inManagedObjectContext:context];
//        }
//        else {
//            people = [matches lastObject];
//            [people setPeopleWithPFObject:object inManagedObjectContext:context];
//        }
//        
//        
//    }
//    
//    return people;
//    
//}
//
//+ (People *)peopleEntityWithRemoteObject: (RemoteObject *)object
//                inManagedObjectContext: (NSManagedObjectContext *)context {
//    return [People peopleEntityWithPFObject:object inManagedObjectContext:context];
//}
//
//
//+ (BOOL) deletePeopleEntityWithPFObject:(PFObject *)object
//                inManagedObjectContext: (NSManagedObjectContext *)context {
//    BOOL ret = NO;
//    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:PF_PEOPLE_CLASS_NAME] ;
//    request.predicate = [NSPredicate predicateWithFormat:@"globalID = %@", object[PF_PEOPLE_OBJECTID]];
//    NSError *error;
//    NSArray *matches = [context executeFetchRequest:request error:&error   ];
//    if (!matches || ([matches count]>1)) {
//        NSAssert(NO, @"match count is not unique");
//    }
//    else if (![matches count]) {
//        //create a new one
//        ret = NO;
//    }
//    else {
//        [context deleteObject:[matches lastObject]];
//        ret = YES;
//    }
//    
//    return ret;
//}
//
//+ (BOOL) deletePeopleEntityWithRemoteObject:(RemoteObject *)object
//                    inManagedObjectContext: (NSManagedObjectContext *)context {
//    return [People deletePeopleEntityWithRemoteObject:object inManagedObjectContext:context];
//}
//
//+ (People *)createPeopleEntity:(NSManagedObjectContext *)context {
//    People * people = nil;
//    
//    //create a new one
//    people = [NSEntityDescription insertNewObjectForEntityForName:PF_PEOPLE_CLASS_NAME
//                                          inManagedObjectContext:context];
//    
//    return people;
//}
//
//
//+ (NSArray *) fetchPeopleEntityAll:(NSManagedObjectContext *)context {
//    
//    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:PF_PEOPLE_CLASS_NAME] ;
//    NSError *error;
//    NSArray *matches = [context executeFetchRequest:request error:&error   ];
//    
//    NSAssert(matches, @"fetch failes");
//    
//    return matches;
//}
//
//+ (void) clearPeopleEntityAll:(NSManagedObjectContext *)context {
//    NSArray * matches = [self fetchPeopleEntityAll:context];
//    
//    if (!matches) {
//        NSAssert(NO, @"fetch failes");
//        
//    }
//    else if ([matches count]){
//        for (People * people in matches) {
//            [context deleteObject:people];
//        }
//    }
//    
//}
//
//
//+ (People *) latestPeopleEntity:(NSManagedObjectContext *)context {
//    //fetch the lastest update date in persistent storage
//    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:PF_PEOPLE_CLASS_NAME];
//    request.predicate = nil;
//    request.fetchLimit = 1;
//    request.sortDescriptors = @[[NSSortDescriptor
//                                 sortDescriptorWithKey:PF_PEOPLE_UPDATE_TIME
//                                 ascending:NO
//                                 selector:@selector(compare:)],
//                                ];
//    NSError *error = nil;
//    NSArray *matches = [context executeFetchRequest:request error:&error];
//    
//    
//    NSDate * latestCreateDate = nil;
//    People * latestPeople = nil;
//    if (!error) {
//        if (!matches) {
//            NSAssert(NO, @"no people is fetched");
//        }
//        else if (![matches count]) {
//            latestPeople = nil;
//            latestCreateDate = nil;
//        }
//        else {
//            latestPeople =[matches lastObject];
//            latestCreateDate = latestPeople.createTime;
//        }
//    }
//    else {
//        NSAssert(NO, @"fetch failes");
//    }
//    
//    return latestPeople;
//}
//
//+ (void) setPeople:(People *)people withPFObject:(PFObject *)object inManagedObjectContext: (NSManagedObjectContext *)context{
//    
//    people.globalID = object[PF_PEOPLE_OBJECTID];
//    
//    /// TODO may not need update user here
//    // note here, we did not download user1 in people
//    User * user = [CurrentUser getCurrentUser];
//    people.user = user;
//    User * user2 = [User convertFromRemoteUser:object[PF_PEOPLE_USER2] inManagedObjectContext:context];
//    people.contact = user2;
//    
//    PFUser * userPF2 = object[PF_PEOPLE_USER2];
//    people.userID = userPF2[PF_USER_OBJECTID];
//    
//    people.name = object[PF_PEOPLE_NAME] ;
//    people.createTime = object[PF_PEOPLE_CREATE_TIME] ;
//    people.updateTime = object[PF_PEOPLE_UPDATE_TIME] ;
//    
//}
//
//- (void) setPeopleWithPFObject:(PFObject *)object inManagedObjectContext: (NSManagedObjectContext *)context{
//    [People setPeople:self withPFObject:object inManagedObjectContext:context];
//}
//
//- (void) setPeopleWithRemoteObject:(RemoteObject *)object inManagedObjectContext: (NSManagedObjectContext *)context {
//    [self setPeopleWithRemoteObject:object inManagedObjectContext:context];
//}
//


@end
