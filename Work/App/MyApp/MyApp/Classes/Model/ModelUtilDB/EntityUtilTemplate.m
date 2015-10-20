//
//  EntityUtilTemplate.m
//  MyApp
//
//  Created by Linwei Ding on 10/20/15.
//  Copyright © 2015 Linweiding. All rights reserved.
//

#import "EntityUtilTemplate.h"

@implementation ENTITY_UTIL_TEMPLATE_CLASS (Util)
+ (ENTITY_UTIL_TEMPLATE_CLASS *)createEntity: (NSManagedObjectContext *)context {
    ENTITY_UTIL_TEMPLATE_CLASS * object = nil;
    
    //create a new one
    object = [NSEntityDescription insertNewObjectForEntityForName:ENTITY_UTIL_TEMPLATE_CLASS_NAME
                                          inManagedObjectContext:context];

    
    
    return object;
}

+ (ENTITY_UTIL_TEMPLATE_CLASS *)entityWithID:(NSString *)globalID inManagedObjectContext:  (NSManagedObjectContext *)context {
    ENTITY_UTIL_TEMPLATE_CLASS * object = nil;
    
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:ENTITY_UTIL_TEMPLATE_CLASS_NAME] ;
    request.predicate = [NSPredicate predicateWithFormat:@"globalID = %@", globalID];
    NSError *error;
    NSArray *matches = [context executeFetchRequest:request error:&error   ];
    
    if (!matches || ([matches count]>1)) {
        NSAssert(NO, @"match count is not unique");
    }
    else if (![matches count]) {
        //create a new one
        object = [NSEntityDescription insertNewObjectForEntityForName:ENTITY_UTIL_TEMPLATE_CLASS_NAME inManagedObjectContext:context];
        
    }
    else {
        object = [matches lastObject];
    }
    
    return object;
    
}


+ (BOOL) deleteEntityWithID:(NSString *)globalID
          inManagedObjectContext: (NSManagedObjectContext *)context {
    BOOL ret = NO;
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:ENTITY_UTIL_TEMPLATE_CLASS_NAME] ;
    request.predicate = [NSPredicate predicateWithFormat:@"globalID = %@", globalID];
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


+ (NSArray *) fetchEntityAll:(NSManagedObjectContext *)context {
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:ENTITY_UTIL_TEMPLATE_CLASS_NAME] ;
    NSError *error;
    NSArray *matches = [context executeFetchRequest:request error:&error   ];
    
    NSAssert(matches, @"fetch failes");
    
    return matches;
}

+ (void) clearEntityAll:(NSManagedObjectContext *)context {
    NSArray * matches = [self fetchEntityAll:context];
    
    if (!matches) {
        NSAssert(NO, @"fetch failes");
        
    }
    else if ([matches count]){
        for (ENTITY_UTIL_TEMPLATE_CLASS * object in matches) {
            [context deleteObject:object];
        }
    }
    
}


+ (ENTITY_UTIL_TEMPLATE_CLASS *) latestEntity:(NSManagedObjectContext *)context {
    //fetch the lastest update date in persistent storage
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:ENTITY_UTIL_TEMPLATE_CLASS_NAME];
    request.predicate = nil;
    request.fetchLimit = 1;
    request.sortDescriptors = @[[NSSortDescriptor
                                 sortDescriptorWithKey:PF_EVENT_UPDATE_TIME
                                 ascending:NO
                                 selector:@selector(compare:)],
                                ];
    NSError *error = nil;
    NSArray *matches = [context executeFetchRequest:request error:&error];
    
    
    NSDate * latestCreateDate = nil;
    ENTITY_UTIL_TEMPLATE_CLASS * latest = nil;
    if (!error) {
        if (!matches) {
            NSAssert(NO, @"no object is fetched");
        }
        else if (![matches count]) {
            latest = nil;
            latestCreateDate = nil;
        }
        else {
            latest =[matches lastObject];
            latestCreateDate = latest.createTime;
        }
    }
    else {
        NSAssert(NO, @"fetch failes");
    }
    
    return latest;
}




@end
