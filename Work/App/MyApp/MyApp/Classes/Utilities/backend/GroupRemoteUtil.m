//
//  GroupRemoteUtil.m
//  MyApp
//
//  Created by Linwei Ding on 9/30/15.
//  Copyright (c) 2015 AppsFoundation. All rights reserved.
//

#import "AppHeader.h"
#import "GroupRemoteUtil.h"

@implementation GroupRemoteUtil

+ (GroupRemoteUtil *)sharedUtil {
    static dispatch_once_t predicate = 0;
    static GroupRemoteUtil *sharedObject;
    
    dispatch_once(&predicate, ^{
        //initializing singleton object
        sharedObject = [[self alloc] init];
        
    });
    return sharedObject;
}

- (void) loadRemoteGroups:(Group *)latestGroup completionHandler:(REMOTE_ARRAY_BLOCK)block {
    [self loadGroupsFromParse:latestGroup completionHandler:block];
}

- (void) loadGroupsFromParse:(Group *)latestGroup completionHandler:(REMOTE_ARRAY_BLOCK)block {
    
    
	PFUser *user = [PFUser currentUser];
    
	PFQuery *query = [PFQuery queryWithClassName:PF_GROUP_CLASS_NAME];
#warning may be error here to user members
	[query whereKey:PF_GROUP_MEMBERS equalTo:user.objectId];
    
    [query includeKey:PF_GROUP_USER];
    
    [query orderByDescending:PF_GROUP_NAME];
    
    if (latestGroup) {
        //found any recent itme
        [query whereKey:PF_GROUP_UPDATE_TIME greaterThan:latestGroup.updateTime];
    }
    
	[query findObjectsInBackgroundWithBlock:block];
    
}
@end
