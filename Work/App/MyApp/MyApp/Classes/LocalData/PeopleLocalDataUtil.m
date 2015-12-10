//
//  PeopleLocalDataUtility.m
//  MyApp
//
//  Created by Linwei Ding on 11/8/15.
//  Copyright © 2015 Linweiding. All rights reserved.
//
#import "People+Util.h"
#import "User+Util.h"
#import "UserRemoteUtil.h"
#import "ConfigurationManager.h"
#import "PeopleLocalDataUtil.h"

#undef LOCAL_DATA_CLASS_TYPE
#define LOCAL_DATA_CLASS_TYPE People

@implementation PeopleLocalDataUtil

+ (PeopleLocalDataUtil *)sharedUtil {
    static dispatch_once_t predicate = 0;
    static PeopleLocalDataUtil *sharedObject;
    
    dispatch_once(&predicate, ^{
        //initializing singleton object
        sharedObject = [[self alloc] init];
        
        sharedObject.className = PF_PEOPLE_CLASS_NAME;
        
        sharedObject.index = LOCAL_DATA_PEOPLE_INDEX;
    });
    return sharedObject;
}

#pragma mark - Inheritance methods

- (NSArray *)constructDataFromDict:(NSDictionary *)dict {
    
    NSMutableArray *resultArray = [NSMutableArray array];
    
    for (NSDictionary *obj in [dict allValues]) {
        
        LOCAL_DATA_CLASS_TYPE * object = [LOCAL_DATA_CLASS_TYPE createEntity:self.managedObjectContext];
        //Feedback *loadedData = [[Feedback alloc] init];
        
        [self setRandomValues:object data:obj];
        [resultArray addObject:object];
    }
    
    return [NSArray arrayWithArray:resultArray];
}

- (void) setRandomValues: (id) object data:(NSDictionary *)dict{
    [super setRandomValues:object data:dict];
    
    
    LOCAL_DATA_CLASS_TYPE * people = (LOCAL_DATA_CLASS_TYPE *)object;
    
    people.contact  = [User fetchEntityWithUsername:dict[PF_PEOPLE_USER2] inManagedObjectContext:self.managedObjectContext];
    people.name = dict[PF_PEOPLE_NAME];
    
}

- (void) createLocalPeople:(NSString *)name user:(User *)user2 completionHandler:(REMOTE_OBJECT_BLOCK)block{
    
    NSFetchRequest * fetch = [NSFetchRequest fetchRequestWithEntityName:PF_PEOPLE_CLASS_NAME];
    fetch.predicate = [NSPredicate predicateWithFormat:@"contact.globalID == %@", user2.globalID];
    NSError * error;
    NSArray * match = [self.managedObjectContext executeFetchRequest:fetch error:&error];
    //[query setLimit:1000];
    

    if (error == nil) {
        if ([match count] == 0) {
            People * people = [People createEntity:self.managedObjectContext];
            //people.userVolatile = [[ConfigurationManager sharedManager] getCurrentUser];
            people.contact = user2;
            people.name = name;
            [self setCommonValues:people];
            if (block) {
                block(people, error);
            }
            
        }
        else {
            [ProgressHUD showError:@"People already exists."];
        }
    }
    else {
        [ProgressHUD showError:@"PeopleSave query error."];
    }

}

- (void) removeLocalPeople:(User *)user2  completionHandler:(REMOTE_BOOL_BLOCK)block{
    NSFetchRequest * fetch = [NSFetchRequest fetchRequestWithEntityName:PF_PEOPLE_CLASS_NAME];
    fetch.predicate = [NSPredicate predicateWithFormat:@"contact.globalID == %@", user2.globalID];
    NSError * error;
    NSArray * match = [self.managedObjectContext executeFetchRequest:fetch error:&error];
  
    if (error == nil) {
         if ([match count] == 1) {
             //for (PFObject *people in objects)
             People * people = [match firstObject];
             [self.managedObjectContext deleteObject:people];
             if (block) {
                 block(YES, error);
             }
             
         }
         else if ([match count] == 0) {
             [ProgressHUD showError:@"People already deleted."];
             if (block) {
                 block(NO, error);
             }
         }
         else {
             NSAssert(NO, @"Duplicate users");
         }
         
     }
     else {
         if (block) {
             block(NO, error);
         }
         [ProgressHUD showError:@"PeopleSave query error."];
     }
    
}

@end
