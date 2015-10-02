//
//  PeopleRemoteUtil.h
//  MyApp
//
//  Created by Linwei Ding on 10/1/15.
//  Copyright (c) 2015 AppsFoundation. All rights reserved.
//
#import <Parse/Parse.h>
#import "AppHeader.h"
#import <Foundation/Foundation.h>

void			PeopleSave				(PFUser *user1, PFUser *user2);
void			PeopleDelete			(PFUser *user1, PFUser *user2);


@interface PeopleRemoteUtil : NSObject

+ (PeopleRemoteUtil *)sharedUtil;

- (void) loadRemotePeoplesWithCompletionHandler:(REMOTE_ARRAY_BLOCK)block;


- (void) loadRemotePeoples:(People *)latestPeople completionHandler:(REMOTE_ARRAY_BLOCK)block;

- (void) createRemotePeople:(NSString *)name user:(User *)user2 completionHandler:(REMOTE_OBJECT_BLOCK)block;

- (void) createRemotePeople:(NSString *)name user:(User *)user2 inManagedObjectContext:(NSManagedObjectContext *)context ;

- (void) deleteRemotePeople:(User *)user2  completionHandler:(REMOTE_OBJECT_BLOCK)block;

- (void) deleteRemotePeople:(User *)user2  inManagedObjectContext:(NSManagedObjectContext *)context;
@end
