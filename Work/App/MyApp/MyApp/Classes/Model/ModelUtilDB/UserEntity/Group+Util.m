//
//  Group+Util.m
//  MyApp
//
//  Created by Linwei Ding on 9/23/15.
//  Copyright © 2015 AppsFoundation. All rights reserved.
//

#import "AppHeader.h"
#import "User+Util.h"
#import "Group+Util.h"

@implementation Group (Util)
//#pragma property method
//- (id)members {
//    return <#expression#>
//}
//
//-(void)setMembers:(id)members {
//    
//}

+ (Group *)createGroupEntityWithPFObject: (PFObject *)object
                    inManagedObjectContext: (NSManagedObjectContext *)context {
    Group * group = nil;
    
    NSAssert(object, @"input is nil");
    
    //create a new one
    group = [NSEntityDescription insertNewObjectForEntityForName:PF_GROUP_CLASS_NAME
                                           inManagedObjectContext:context];
    //set the group values
    [group setGroupWithPFObject:object inManagedObjectContext:context];
    
    
    return group;
}

+ (Group *)createGroupEntityWithRemoteObject: (RemoteObject *)object
                  inManagedObjectContext: (NSManagedObjectContext *)context {
    return [ Group createGroupEntityWithPFObject:object inManagedObjectContext:context];
}

+ (Group *)groupEntityWithPFObject: (PFObject *)object
              inManagedObjectContext: (NSManagedObjectContext *)context {
    Group * group = nil;
    
    NSAssert(object, @"input is nil");
    
    if (object) {
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:PF_GROUP_CLASS_NAME] ;
        request.predicate = [NSPredicate predicateWithFormat:@"globalID = %@", object[PF_GROUP_OBJECTID]];
        NSError *error;
        NSArray *matches = [context executeFetchRequest:request error:&error   ];
        
        if (!matches || ([matches count]>1)) {
            NSAssert(NO, @"match count is not unique");
        }
        else if (![matches count]) {
            //create a new one
            group = [NSEntityDescription insertNewObjectForEntityForName:PF_GROUP_CLASS_NAME inManagedObjectContext:context];
            //set the group values
            [group setGroupWithPFObject:object inManagedObjectContext:context];
        }
        else {
            group = [matches lastObject];
            [group setGroupWithPFObject:object inManagedObjectContext:context];
        }
        
        
    }
    
    return group;
    
}

+ (Group *)groupEntityWithRemoteObject: (RemoteObject *)object
            inManagedObjectContext: (NSManagedObjectContext *)context {
    return [Group groupEntityWithPFObject:object inManagedObjectContext:context];
}


+ (BOOL) deleteGroupEntityWithPFObject:(PFObject *)object
                 inManagedObjectContext: (NSManagedObjectContext *)context {
    BOOL ret = NO;
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:PF_GROUP_CLASS_NAME] ;
    request.predicate = [NSPredicate predicateWithFormat:@"globalID = %@", object[PF_GROUP_OBJECTID]];
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

+ (BOOL) deleteGroupEntityWithRemoteObject:(RemoteObject *)object
                inManagedObjectContext: (NSManagedObjectContext *)context {
    return [Group deleteGroupEntityWithRemoteObject:object inManagedObjectContext:context];
}

+ (Group *)createGroupEntity:(NSManagedObjectContext *)context {
    Group * group = nil;
    
    //create a new one
    group = [NSEntityDescription insertNewObjectForEntityForName:PF_GROUP_CLASS_NAME
                                           inManagedObjectContext:context];
    
    return group;
}


+ (NSArray *) fetchGroupEntityAll:(NSManagedObjectContext *)context {
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:PF_GROUP_CLASS_NAME] ;
    NSError *error;
    NSArray *matches = [context executeFetchRequest:request error:&error   ];
    
     NSAssert(matches, @"fetch failes");
    
    return matches;
}

+ (void) clearGroupEntityAll:(NSManagedObjectContext *)context {
    NSArray * matches = [self fetchGroupEntityAll:context];
    
    if (!matches) {
        NSAssert(NO, @"fetch failes");
        
    }
    else if ([matches count]){
        for (Group * group in matches) {
            [context deleteObject:group];
        }
    }
    
}


+ (Group *) latestGroupEntity:(NSManagedObjectContext *)context {
    //fetch the lastest update date in persistent storage
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:PF_GROUP_CLASS_NAME];
    request.predicate = nil;
    request.fetchLimit = 1;
    request.sortDescriptors = @[[NSSortDescriptor
                                 sortDescriptorWithKey:PF_GROUP_UPDATE_TIME
                                 ascending:NO
                                 selector:@selector(compare:)],
                                ];
    NSError *error = nil;
    NSArray *matches = [context executeFetchRequest:request error:&error];
    
    
    NSDate * latestCreateDate = nil;
    Group * latestGroup = nil;
    if (!error) {
        if (!matches) {
            NSAssert(NO, @"no group is fetched");
        }
        else if (![matches count]) {
            latestGroup = nil;
            latestCreateDate = nil;
        }
        else {
            latestGroup =[matches lastObject];
            latestCreateDate = latestGroup.createTime;
        }
    }
    else {
        NSAssert(NO, @"fetch failes");
    }
    
    return latestGroup;
}
+ (void) setGroup:(Group *)group withPFObject:(PFObject *)object inManagedObjectContext: (NSManagedObjectContext *)context{
    
    group.globalID = object[PF_GROUP_OBJECTID];
    
    /// TODO may not need update user here
    User * user = [User convertFromRemoteUser:object[PF_GROUP_USER] inManagedObjectContext:context];
    group.user = user;
    
    group.members = object[PF_GROUP_MEMBERS] ;
    group.name = object[PF_GROUP_NAME] ;
        group.createTime = object.createdAt ;
        group.updateTime = object.updatedAt ;

}

- (void) setGroupWithPFObject:(PFObject *)object inManagedObjectContext: (NSManagedObjectContext *)context{
    [Group setGroup:self withPFObject:object inManagedObjectContext:context];
}

- (void) setGroupWithRemoteObject:(RemoteObject *)object inManagedObjectContext: (NSManagedObjectContext *)context {
    [self setGroupWithRemoteObject:object inManagedObjectContext:context];
}


@end
