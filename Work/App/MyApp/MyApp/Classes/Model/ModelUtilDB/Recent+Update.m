//
//  Recent+Update.m
//  MyApp
//
//  Created by Linwei Ding on 9/22/15.
//  Copyright (c) 2015 AppsFoundation. All rights reserved.
//
#import "AppConstant.h"

#import "Recent+Update.h"

@implementation Recent (Update)

//-------------------------------------------------------------------------------------------------------------------------------------------------
// Create or get the object from data base
//-------------------------------------------------------------------------------------------------------------------------------------------------
+ (Recent *)createRecentEntityWithPFObject: (PFObject *)object
        inManagedObjectContext: (NSManagedObjectContext *)context {
    Recent * recent = nil;
    
    NSAssert(object, @"input is nil");

    //create a new one
    recent = [NSEntityDescription insertNewObjectForEntityForName:@"Recent" inManagedObjectContext:context];
    //set the recent values
    [Recent setRecent:recent withPFObject:object];

    
    return recent;
}



+ (Recent *)recentEntityWithPFObject: (PFObject *)object
    inManagedObjectContext: (NSManagedObjectContext *)context {
    Recent * recent = nil;
    
    NSAssert(object, @"input is nil");
    
    if (object) {
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Recent"] ;
        request.predicate = [NSPredicate predicateWithFormat:@"chatID = %@", object[PF_RECENT_GROUPID]];
        NSError *error;
        NSArray *matches = [context executeFetchRequest:request error:&error   ];
        
        if (!matches || ([matches count]>1)) {
            NSAssert(NO, @"match count is not unique");
        }
        else if (![matches count]) {
            //create a new one
            recent = [NSEntityDescription insertNewObjectForEntityForName:@"Recent" inManagedObjectContext:context];
             //set the recent values
            [Recent setRecent:recent withPFObject:object];
        }
        else {
            recent = [matches lastObject];
        }
             
            
    }
    
    return recent;
             
}

+ (BOOL) deleteRecentEntityWithPFObject:(PFObject *)object
                 inManagedObjectContext: (NSManagedObjectContext *)context {
    BOOL ret = NO;
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Recent"] ;
    request.predicate = [NSPredicate predicateWithFormat:@"groupId = %@", object[PF_RECENT_GROUPID]];
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
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Recent"] ;
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
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Recent"];
    request.predicate = nil;
    request.fetchLimit = 1;
    request.sortDescriptors = @[[NSSortDescriptor
                                 sortDescriptorWithKey:@"updateDate"
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

             
+ (void) setRecent:(Recent *)recent withPFObject:(PFObject *)object {
    PFUser * user = object[PF_RECENT_USER];
    
    //recent.user = object[PF_RECENT_USER];
    recent.chatId =  object[PF_RECENT_GROUPID];
    recent.chatId = object[PF_RECENT_MEMBERS] ;
    recent.chatId = object[PF_RECENT_DESCRIPTION] ;
    //recent.chatId = object[PF_RECENT_LASTUSER] ;
    recent.chatId = object[PF_RECENT_LASTMESSAGE] ;
    recent.chatId = object[PF_RECENT_COUNTER] ;
    recent.chatId = object[PF_RECENT_UPDATEDACTION];
}


@end
