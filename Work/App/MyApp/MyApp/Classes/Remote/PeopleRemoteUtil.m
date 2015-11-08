//
//  PeopleRemoteUtil.m
//  MyApp
//
//  Created by Linwei Ding on 10/1/15.
//  Copyright (c) 2015 AppsFoundation. All rights reserved.
//
#import "People+Util.h"
#import "User+Util.h"
#import "PeopleRemoteUtil.h"
#import "CurrentUser+Util.h"
#import <Parse/Parse.h>
#import "UserRemoteUtil.h"
#import "AppConstant.h"


//
////-------------------------------------------------------------------------------------------------------------------------------------------------
//void PeopleSave(PFUser *user1, PFUser *user2)
////-------------------------------------------------------------------------------------------------------------------------------------------------
//{
//	PFQuery *query = [PFQuery queryWithClassName:PF_PEOPLE_CLASS_NAME];
//	[query whereKey:PF_PEOPLE_USER1 equalTo:user1];
//	[query whereKey:PF_PEOPLE_USER2 equalTo:user2];
//	[query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error)
//     {
//         if (error == nil)
//         {
//             if ([objects count] == 0)
//             {
//                 PFObject *object = [PFObject objectWithClassName:PF_PEOPLE_CLASS_NAME];
//                 object[PF_PEOPLE_USER1] = user1;
//                 object[PF_PEOPLE_USER2] = user2;
//                 [object saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error)
//                  {
//                      if (error != nil) NSLog(@"PeopleSave save error.");
//                  }];
//             }
//         }
//         else NSLog(@"PeopleSave query error.");
//     }];
//}
//
////-------------------------------------------------------------------------------------------------------------------------------------------------
//void PeopleDelete(PFUser *user1, PFUser *user2)
////-------------------------------------------------------------------------------------------------------------------------------------------------
//{
//	PFQuery *query = [PFQuery queryWithClassName:PF_PEOPLE_CLASS_NAME];
//	[query whereKey:PF_PEOPLE_USER1 equalTo:user1];
//	[query whereKey:PF_PEOPLE_USER2 equalTo:user2];
//	[query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error)
//     {
//         if (error == nil)
//         {
//             for (PFObject *people in objects)
//             {
//                 [people deleteInBackgroundWithBlock:^(BOOL succeeded, NSError *error)
//                  {
//                      if (error != nil) NSLog(@"PeopleDelete delete error.");
//                  }];
//             }
//         }
//         else NSLog(@"PeopleDelete query error.");
//     }];
//}

#define BASE_REMOTE_UTIL_OBJ_TYPE ObjectEntity*


@implementation PeopleRemoteUtil


+ (PeopleRemoteUtil *)sharedUtil {
    static dispatch_once_t predicate = 0;
    static PeopleRemoteUtil *sharedObject;
    
    dispatch_once(&predicate, ^{
        //initializing singleton object
        sharedObject = [[self alloc] init];
        
        sharedObject.className = PF_PEOPLE_CLASS_NAME;
    });
    return sharedObject;
}

- (void) setCommonObject:(BASE_REMOTE_UTIL_OBJ_TYPE)object withRemoteObject:(RemoteObject *)remoteObj inManagedObjectContext: (NSManagedObjectContext *)context{
    NSAssert([object isKindOfClass:[People class]], @"Type casting is wrong");
    People * people = (People *)object;
    
    //people.user = [[ConfigurationManager sharedManager] getCurrentUser];
    people.contact  = [[UserRemoteUtil sharedUtil] convertToUser:remoteObj[PF_PEOPLE_USER2]];
    people.name = remoteObj[PF_PEOPLE_NAME];
    
}

- (void) setCommonRemoteObject:(RemoteObject *)remoteObj withAlert:(BASE_REMOTE_UTIL_OBJ_TYPE)object {
    NSAssert([object isKindOfClass:[People class]], @"Type casting is wrong");
    People * people = (People *)object;
    
    remoteObj[PF_PEOPLE_USER1] = [PFUser currentUser];
    remoteObj[PF_PEOPLE_USER2] = [[UserRemoteUtil sharedUtil] convertToRemoteUser:people.contact];
    // no need to set create time and update time and object ID
    remoteObj[PF_PEOPLE_NAME] = people.name;

}


//
//- (void) loadRemotePeoplesWithCompletionHandler:(REMOTE_ARRAY_BLOCK)block{
//    
////    PFUser *user = [PFUser currentUser];
////    
////	PFQuery *query1 = [PFQuery queryWithClassName:PF_BLOCKED_CLASS_NAME];
////	[query1 whereKey:PF_BLOCKED_USER1 equalTo:user];
////    [query2 whereKey:PF_USER_OBJECTID notEqualTo:user.objectId];
////	[query2 whereKey:PF_USER_OBJECTID doesNotMatchKey:PF_BLOCKED_USERID2 inQuery:query1];
//#warning add blocked user concerns
//    PFQuery *query = [PFQuery queryWithClassName:PF_PEOPLE_CLASS_NAME];
//	[query whereKey:PF_PEOPLE_USER1 equalTo:[PFUser currentUser]];
//	[query includeKey:PF_PEOPLE_USER2];
//	[query setLimit:PEOPLEVIEW_ITEM_NUM];
//    
//    [query orderByDescending:PF_PEOPLE_NAME];
//    
//	[query findObjectsInBackgroundWithBlock:block];
//    
//    
//}

- (void) loadRemotePeoples:(People *)latestPeople completionHandler:(REMOTE_ARRAY_BLOCK)block {
    [self loadPeoplesFromParse:latestPeople completionHandler:block];
}

- (void) loadPeoplesFromParse:(People *)latestPeople completionHandler:(REMOTE_ARRAY_BLOCK)block {
    
    
	PFQuery *query = [PFQuery queryWithClassName:PF_PEOPLE_CLASS_NAME];
    [query whereKey:PF_PEOPLE_USER1 equalTo:[PFUser currentUser]];
	[query includeKey:PF_PEOPLE_USER2];
	[query setLimit:PEOPLEVIEW_ITEM_NUM];
    
    [query orderByDescending:PF_PEOPLE_NAME];
    
    if (latestPeople) {
        //found any recent itme
        [query whereKey:PF_PEOPLE_UPDATE_TIME greaterThan:latestPeople.updateTime];
        [self downloadObjectsWithQuery:query completionHandler:^(NSArray *remoteObjs, NSArray *objects, NSError *error) {
            block(objects, error);
        }];
    }
    else {
        [self downloadCreateObjectsWithQuery:query completionHandler:^(NSArray *remoteObjs, NSArray *objects, NSError *error) {
            block(objects, error);
        }];
    }
}

- (void) createRemotePeople:(NSString *)name user:(User *)user2 completionHandler:(REMOTE_OBJECT_BLOCK)block{

    PFQuery *query = [PFQuery queryWithClassName:PF_PEOPLE_CLASS_NAME];
	[query whereKey:PF_PEOPLE_USER1 equalTo:[PFUser currentUser]];
	[query whereKey:PF_PEOPLE_USER2 equalTo:[[UserRemoteUtil sharedUtil] convertToRemoteUser:user2] ];
	[query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error)
     {
        if (error == nil)
        {
            if ([objects count] == 0)
            {
                People * people = [People createEntity:nil];
                people.userVolatile = [[ConfigurationManager sharedManager] getCurrentUser];
                people.contact = user2;
                people.name = name;
                [self uploadCreateRemoteObject:people completionHandler:block];
            }
            else {
                [ProgressHUD showError:@"People already exists."];
            }
        }
        else {
            [ProgressHUD showError:@"PeopleSave query error."];
        }
    }];
}


- (void) deleteRemotePeople:(User *)user2  completionHandler:(REMOTE_BOOL_BLOCK)block{
    PFQuery *query = [PFQuery queryWithClassName:PF_PEOPLE_CLASS_NAME];
	[query whereKey:PF_PEOPLE_USER1 equalTo:[PFUser currentUser]];
	[query whereKey:PF_PEOPLE_USER2 equalTo:[[UserRemoteUtil sharedUtil] convertToRemoteUser:user2] ];
	[query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error)
     {
         if (error == nil)
         {
             if ([objects count] == 1) {
                 //for (PFObject *people in objects)
                 PFObject * peopleRMT = [objects firstObject];
                 People * people = [People entityWithID:peopleRMT.objectId inManagedObjectContext:user2.managedObjectContext];
                 if (people) {
                     //local exist
                     [self uploadRemoveRemoteObject:people completionHandler:block];
                 }
                 else {
                     // local not exist
                     [peopleRMT deleteInBackgroundWithBlock:block];
                 }
             }
             else if ([objects count] == 0) {
                 [ProgressHUD showError:@"People already deleted."];
             }
             else {
                 NSAssert(NO, @"Duplicate users");
             }

         }
         else {
             [ProgressHUD showError:@"PeopleSave query error."];
         }
     }];
}

//- (void) deleteRemotePeople:(User *)user2  inManagedObjectContext:(NSManagedObjectContext *)context{
//    
//    [self deleteRemotePeople:user2 completionHandler:^(BOOL succeeded, NSError *error, PFObject *object) {
//        if (error != nil) {
//            [ProgressHUD showError:@"PeopleDelete delete error"];
//        }
//        else if (succeeded ){
//            [People deletePeopleEntityWithRemoteObject:object inManagedObjectContext:context];
//        }
//    }];
//}


@end
