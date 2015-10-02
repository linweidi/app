//
//  PeopleRemoteUtil.m
//  MyApp
//
//  Created by Linwei Ding on 10/1/15.
//  Copyright (c) 2015 AppsFoundation. All rights reserved.
//
#import "People+Util.h"

#import "PeopleRemoteUtil.h"

#import <Parse/Parse.h>

#import "AppConstant.h"



//-------------------------------------------------------------------------------------------------------------------------------------------------
void PeopleSave(PFUser *user1, PFUser *user2)
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	PFQuery *query = [PFQuery queryWithClassName:PF_PEOPLE_CLASS_NAME];
	[query whereKey:PF_PEOPLE_USER1 equalTo:user1];
	[query whereKey:PF_PEOPLE_USER2 equalTo:user2];
	[query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error)
     {
         if (error == nil)
         {
             if ([objects count] == 0)
             {
                 PFObject *object = [PFObject objectWithClassName:PF_PEOPLE_CLASS_NAME];
                 object[PF_PEOPLE_USER1] = user1;
                 object[PF_PEOPLE_USER2] = user2;
                 [object saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error)
                  {
                      if (error != nil) NSLog(@"PeopleSave save error.");
                  }];
             }
         }
         else NSLog(@"PeopleSave query error.");
     }];
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
void PeopleDelete(PFUser *user1, PFUser *user2)
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	PFQuery *query = [PFQuery queryWithClassName:PF_PEOPLE_CLASS_NAME];
	[query whereKey:PF_PEOPLE_USER1 equalTo:user1];
	[query whereKey:PF_PEOPLE_USER2 equalTo:user2];
	[query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error)
     {
         if (error == nil)
         {
             for (PFObject *people in objects)
             {
                 [people deleteInBackgroundWithBlock:^(BOOL succeeded, NSError *error)
                  {
                      if (error != nil) NSLog(@"PeopleDelete delete error.");
                  }];
             }
         }
         else NSLog(@"PeopleDelete query error.");
     }];
}

@implementation PeopleRemoteUtil


+ (PeopleRemoteUtil *)sharedUtil {
    static dispatch_once_t predicate = 0;
    static PeopleRemoteUtil *sharedObject;
    
    dispatch_once(&predicate, ^{
        //initializing singleton object
        sharedObject = [[self alloc] init];
        
    });
    return sharedObject;
}


- (void) loadRemotePeoplesWithCompletionHandler:(REMOTE_ARRAY_BLOCK)block{
    
//    PFUser *user = [PFUser currentUser];
//    
//	PFQuery *query1 = [PFQuery queryWithClassName:PF_BLOCKED_CLASS_NAME];
//	[query1 whereKey:PF_BLOCKED_USER1 equalTo:user];
//    [query2 whereKey:PF_USER_OBJECTID notEqualTo:user.objectId];
//	[query2 whereKey:PF_USER_OBJECTID doesNotMatchKey:PF_BLOCKED_USERID2 inQuery:query1];
#warning add blocked user concerns
    PFQuery *query = [PFQuery queryWithClassName:PF_PEOPLE_CLASS_NAME];
	[query whereKey:PF_PEOPLE_USER1 equalTo:[PFUser currentUser]];
	[query includeKey:PF_PEOPLE_USER2];
	[query setLimit:PEOPLEVIEW_ITEM_NUM];
    
    [query orderByDescending:PF_PEOPLE_NAME];
    
	[query findObjectsInBackgroundWithBlock:block];
    
    
}

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
    }
    
	[query findObjectsInBackgroundWithBlock:block];
    
}

- (void) createRemotePeople:(NSString *)name user:(User *)user2 completionHandler:(REMOTE_OBJECT_BLOCK)block{
#warning we can check local data of user's friend attribute to confirm if it the remote people already exists
    PFQuery *query = [PFQuery queryWithClassName:PF_PEOPLE_CLASS_NAME];
	[query whereKey:PF_PEOPLE_USER1 equalTo:[CurrentUser getCurrentUser]];
	[query whereKey:PF_PEOPLE_USER2 equalTo:[user2 convertToPFUser] ];
	[query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error)
     {
         if (error == nil)
         {
             if ([objects count] == 0)
             {
                 PFObject *object = [PFObject objectWithClassName:PF_PEOPLE_CLASS_NAME];
                 object[PF_PEOPLE_USER1] = [PFUser currentUser];
                 object[PF_PEOPLE_USER2] = [user2 convertToPFUser];
                 // no need to set create time and update time and object ID
                 object[PF_PEOPLE_NAME] = name;
                 [object saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                     block(succeeded, error, object);
                 }];
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

- (void) createRemotePeople:(NSString *)name user:(User *)user2 inManagedObjectContext:(NSManagedObjectContext *)context {
    
    [self createRemotePeople:name user:user2 completionHandler:^(BOOL succeeded, NSError *error, PFObject *object) {
        if (error != nil) {
            [ProgressHUD showError:@"CreateRemotePeople save error."];
        }
        else if (succeeded){
            People * obj = [People peopleEntityWithRemoteObject:object inManagedObjectContext:context];
            
            if (!obj) {
                [ProgressHUD showError:@"CreateRemotePeople does not insert into core data."];
                ///TODO delete the saved data on server or redo the local save
            }
        }
    }];
}

- (void) deleteRemotePeople:(User *)user2  completionHandler:(REMOTE_OBJECT_BLOCK)block{
    PFQuery *query = [PFQuery queryWithClassName:PF_PEOPLE_CLASS_NAME];
	[query whereKey:PF_PEOPLE_USER1 equalTo:[PFUser currentUser]];
	[query whereKey:PF_PEOPLE_USER2 equalTo:[user2 convertToPFUser] ];
	[query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error)
     {
         if (error == nil)
         {
             if ([objects count] == 1) {
                 //for (PFObject *people in objects)

                 PFObject * peoplePF = [objects firstObject];
                 [peoplePF deleteInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                     block(succeeded, error, peoplePF);
                 }];

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

- (void) deleteRemotePeople:(User *)user2  inManagedObjectContext:(NSManagedObjectContext *)context{
    
    [self deleteRemotePeople:user2 completionHandler:^(BOOL succeeded, NSError *error, PFObject *object) {
        if (error != nil) {
            [ProgressHUD showError:@"PeopleDelete delete error"];
        }
        else if (succeeded ){
            [People deletePeopleEntityWithRemoteObject:object inManagedObjectContext:context];
        }
    }];
}


@end
