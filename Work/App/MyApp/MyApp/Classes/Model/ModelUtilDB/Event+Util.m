//
//  Event+Util.m
//  MyApp
//
//  Created by Linwei Ding on 9/23/15.
//  Copyright © 2015 AppsFoundation. All rights reserved.
//

#import "AppConstant.h"
#import "Event+Util.h"

@implementation Event (Util)
+ (Event *)createEventEntity: (NSManagedObjectContext *)context {
    Event * event = nil;
    
    //create a new one
    event = [NSEntityDescription insertNewObjectForEntityForName:PF_EVENT_CLASS_NAME
                                inManagedObjectContext:context];
    //set the event values
    //[event setEventWithPFObject:object inManagedObjectContext:context];
    
    
    return event;
}

+ (Event *)eventEntityWithID:(NSString *)globalID inManagedObjectContext:  (NSManagedObjectContext *)context {
    Event * event = nil;
    

        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:PF_EVENT_CLASS_NAME] ;
        request.predicate = [NSPredicate predicateWithFormat:@"globalID = %@", globalID];
        NSError *error;
        NSArray *matches = [context executeFetchRequest:request error:&error   ];
        
        if (!matches || ([matches count]>1)) {
            NSAssert(NO, @"match count is not unique");
        }
        else if (![matches count]) {
            //create a new one
            event = [NSEntityDescription insertNewObjectForEntityForName:PF_EVENT_CLASS_NAME inManagedObjectContext:context];

        }
        else {
            event = [matches lastObject];
        }
    
    return event;
    
}


+ (BOOL) deleteEventEntityWithID:(NSString *)globalID
                inManagedObjectContext: (NSManagedObjectContext *)context {
    BOOL ret = NO;
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:PF_EVENT_CLASS_NAME] ;
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


//
//+ (Event *)createEventEntity:(NSManagedObjectContext *)context {
//    Event * event = nil;
//    
//    //create a new one
//    event = [NSEntityDescription insertNewObjectForEntityForName:PF_EVENT_CLASS_NAME
//                                          inManagedObjectContext:context];
//    
//    return event;
//}


+ (NSArray *) fetchEventEntityAll:(NSManagedObjectContext *)context {
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:PF_EVENT_CLASS_NAME] ;
    NSError *error;
    NSArray *matches = [context executeFetchRequest:request error:&error   ];
    
    NSAssert(matches, @"fetch failes");
    
    return matches;
}

+ (void) clearEventEntityAll:(NSManagedObjectContext *)context {
    NSArray * matches = [self fetchEventEntityAll:context];
    
    if (!matches) {
        NSAssert(NO, @"fetch failes");
        
    }
    else if ([matches count]){
        for (Event * event in matches) {
            [context deleteObject:event];
        }
    }
    
}


+ (Event *) latestEventEntity:(NSManagedObjectContext *)context {
    //fetch the lastest update date in persistent storage
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:PF_EVENT_CLASS_NAME];
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
    Event * latestEvent = nil;
    if (!error) {
        if (!matches) {
            NSAssert(NO, @"no event is fetched");
        }
        else if (![matches count]) {
            latestEvent = nil;
            latestCreateDate = nil;
        }
        else {
            latestEvent =[matches lastObject];
            latestCreateDate = latestEvent.createTime;
        }
    }
    else {
        NSAssert(NO, @"fetch failes");
    }
    
    return latestEvent;
}




@end
