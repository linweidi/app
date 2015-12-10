//
//  EventCategory+Util.m
//  MyApp
//
//  Created by Linwei Ding on 10/21/15.
//  Copyright (c) 2015 Linweiding. All rights reserved.
//

#import "EventCategory+Util.h"

@implementation EventCategory (Util)

#undef ENTITY_UTIL_TEMPLATE_CLASS
#undef ENTITY_UTIL_TEMPLATE_CLASS_NAME
#define ENTITY_UTIL_TEMPLATE_CLASS EventCategory
#define ENTITY_UTIL_TEMPLATE_CLASS_NAME @"EventCategory"

#include "../Template/EntityUtilTemplate.mh"


+ (ENTITY_UTIL_TEMPLATE_CLASS *)entityWithLocalID:(NSString *)localID inManagedObjectContext:  (NSManagedObjectContext *)context {
    ENTITY_UTIL_TEMPLATE_CLASS * object = nil;
    
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:ENTITY_UTIL_TEMPLATE_CLASS_NAME] ;
    request.predicate = [NSPredicate predicateWithFormat:@"localID = %@", [NSString stringWithFormat:@"%@", localID]];
    NSError *error;
    NSArray *matches = [context executeFetchRequest:request error:&error   ];
    
    if (!matches || ([matches count]>1)) {
        NSAssert(NO, @"match count is not unique");
    }
    else if (![matches count]) {
        //create a new one
        //object = [NSEntityDescription insertNewObjectForEntityForName:ENTITY_UTIL_TEMPLATE_CLASS_NAME inManagedObjectContext:context];
        
    }
    else {
        object = [matches lastObject];
    }
    
    return object;
}


@end
