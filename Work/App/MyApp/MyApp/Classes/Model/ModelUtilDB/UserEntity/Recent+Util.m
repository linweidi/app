//
//  Recent+Util.m
//  MyApp
//
//  Created by Linwei Ding on 9/23/15.
//  Copyright © 2015 AppsFoundation. All rights reserved.
//
#import <Parse/Parse.h>

#import "AppConstant.h"
#import "User+Util.h"

#import "Recent+Util.h"

@implementation Recent (Util)

//-------------------------------------------------------------------------------------------------------------------------------------------------
// Create or get the object from data base
//-------------------------------------------------------------------------------------------------------------------------------------------------
+ (Recent *)createRecentEntityWithPFObject: (PFObject *)object
                    inManagedObjectContext: (NSManagedObjectContext *)context {
    Recent * recent = nil;
    
    NSAssert(object, @"input is nil");
    
    //create a new one
    recent = [NSEntityDescription insertNewObjectForEntityForName:PF_RECENT_CLASS_NAME
                                           inManagedObjectContext:context];
    //set the recent values
    [Recent setRecent:recent withPFObject:object inManagedObjectContext:context];
    
    
    return recent;
}



+ (Recent *)recentEntityWithPFObject: (PFObject *)object
              inManagedObjectContext: (NSManagedObjectContext *)context {
    Recent * recent = nil;
    
    NSAssert(object, @"input is nil");
    
    if (object) {
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:PF_RECENT_CLASS_NAME] ;
        request.predicate = [NSPredicate predicateWithFormat:@"chatID = %@", object[PF_RECENT_GROUPID]];
        NSError *error;
        NSArray *matches = [context executeFetchRequest:request error:&error   ];
        
        if (!matches || ([matches count]>1)) {
            NSAssert(NO, @"match count is not unique");
        }
        else if (![matches count]) {
            //create a new one
            recent = [NSEntityDescription insertNewObjectForEntityForName:PF_RECENT_CLASS_NAME inManagedObjectContext:context];
            //set the recent values
            [Recent setRecent:recent withPFObject:object inManagedObjectContext:context];
        }
        else {
            recent = [matches lastObject];
            [Recent setRecent:recent withPFObject:object inManagedObjectContext:context];
        }
        
        
    }
    
    return recent;
    
}

+ (BOOL) deleteRecentEntityWithPFObject:(PFObject *)object
                 inManagedObjectContext: (NSManagedObjectContext *)context {
    BOOL ret = NO;
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:PF_RECENT_CLASS_NAME] ;
    request.predicate = [NSPredicate predicateWithFormat:@"chatID = %@", object[PF_RECENT_GROUPID]];
    NSError *error;
    NSArray *matches = [context executeFetchRequest:request error:&error   ];
    if (!matches || ([matches count]>1)) {
        NSAssert(NO, @"match count is not unique");
    }
    else if (![matches count]) {
        //create a new one
        ret = NO;
    }
    else {
        [context deleteObject:[matches lastObject]];
        ret = YES;
    }
    
    return ret;
}

+ (Recent *)createRecentEntity:(NSManagedObjectContext *)context {
    Recent * recent = nil;

    //create a new one
    recent = [NSEntityDescription insertNewObjectForEntityForName:PF_RECENT_CLASS_NAME
                                           inManagedObjectContext:context];
    
    return recent;
}



+ (Recent *)recentEntitywithChatID:(NSString *)chatID
              inManagedObjectContext: (NSManagedObjectContext *)context {
    Recent * recent = nil;
    
    if (chatID) {
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:PF_RECENT_CLASS_NAME] ;
        request.predicate = [NSPredicate predicateWithFormat:@"chatID = %@", chatID];
        NSError *error;
        NSArray *matches = [context executeFetchRequest:request error:&error   ];
        
        if (!matches || ([matches count]>1)) {
            NSAssert(NO, @"match count is not unique");
        }
        else if (![matches count]) {
            //create a new one
            recent = [NSEntityDescription insertNewObjectForEntityForName:PF_RECENT_CLASS_NAME inManagedObjectContext:context];
        }
        else {
            //update
            recent = [matches lastObject];
        }
        
        
    }
    
    return recent;
    
}

+ (BOOL) deleteRecentEntityWithChatID:(NSString *)chatID
                 inManagedObjectContext: (NSManagedObjectContext *)context {
    BOOL ret = NO;
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:PF_RECENT_CLASS_NAME] ;
    request.predicate = [NSPredicate predicateWithFormat:@"chatID = %@", chatID];
    NSError *error;
    NSArray *matches = [context executeFetchRequest:request error:&error   ];
    if (!matches || ([matches count]>1)) {
        NSAssert(NO, @"match count is not unique");
    }
    else if (![matches count]) {
        //create a new one
        ret = NO;
    }
    else {
        [context deleteObject:[matches lastObject]];
        ret = YES;
    }
    
    return ret;
}

+ (NSArray *) fetchRecentEntityAll:(NSManagedObjectContext *)context {
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:PF_RECENT_CLASS_NAME] ;
    NSError *error;
    NSArray *matches = [context executeFetchRequest:request error:&error   ];
    
    return matches;
}

+ (void) clearRecentEntityAll:(NSManagedObjectContext *)context {
    NSArray * matches = [self fetchRecentEntityAll:context];
    
    if (!matches) {
        NSAssert(NO, @"fetch failes");
        
    }
    else if ([matches count]){
        for (Recent * recent in matches) {
            [context deleteObject:recent];
        }
    }
    
}

+ (Recent *) latestRecentEntity:(NSManagedObjectContext *)context {
    //fetch the lastest update date in persistent storage
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:PF_RECENT_CLASS_NAME];
    request.predicate = nil;
    request.fetchLimit = 1;
    request.sortDescriptors = @[[NSSortDescriptor
                                 sortDescriptorWithKey:PF_RECENT_UPDATEDACTION
                                 ascending:NO
                                 selector:@selector(compare:)],
                                ];
    NSError *error = nil;
    NSArray *matches = [context executeFetchRequest:request error:&error];
    
    
    NSDate * latestUpdateDate = nil;
    Recent * latestRecent = nil;
    if (!error) {
        if (!matches) {
            NSAssert(NO, @"no recent is fetched");
        }
        else if (![matches count]) {
            latestRecent = nil;
            latestUpdateDate = nil;
        }
        else {
            latestRecent =[matches lastObject];
            latestUpdateDate = latestRecent.updateDate;
        }
    }
    else {
        NSAssert(NO, @"fetch failes");
    }
    
    return latestRecent;
}
//-------------------------------------------------------------------------------------------------------------------------------------------------
// Create or get object from plist


+ (void) setRecent:(Recent *)recent withPFObject:(PFObject *)object inManagedObjectContext: (NSManagedObjectContext *)context{
    
    recent.globalID = object.objectId;
    
    /// TODO may not need update user here
    User * user = [User convertFromRemoteUser:object[PF_RECENT_USER] inManagedObjectContext:context];
    recent.user = user;
    
    recent.chatID =  object[PF_RECENT_GROUPID];
    recent.member = object[PF_RECENT_MEMBERS] ;
    recent.details = object[PF_RECENT_DESCRIPTION] ;

    /// TODO may not need update user here
    User * lastUser = [User convertFromRemoteUser:object[PF_RECENT_LASTUSER] inManagedObjectContext:context];
    recent.lastUser = lastUser;

    
    recent.lastMessage = object[PF_RECENT_LASTMESSAGE] ;
    recent.counter = object[PF_RECENT_COUNTER] ;
    recent.updateDate = object[PF_RECENT_UPDATEDACTION];
}

- (void) setRecentWithPFObject:(PFObject *)object inManagedObjectContext: (NSManagedObjectContext *)context{
    [Recent setRecent:self withPFObject:object inManagedObjectContext:context];
}



@end
