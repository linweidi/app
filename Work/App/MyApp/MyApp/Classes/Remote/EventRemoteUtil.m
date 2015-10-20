//
//  EventRemoteUtil.m
//  MyApp
//
//  Created by Linwei Ding on 10/19/15.
//  Copyright (c) 2015 AppsFoundation. All rights reserved.
//
#import "Event+Util.h"
#import "AppHeader.h"
#import "EventRemoteUtil.h"

@implementation EventRemoteUtil

+ (void) setEvent:(Event *)event withPFObject:(PFObject *)object inManagedObjectContext: (NSManagedObjectContext *)context{
    
    event.globalID = object[PF_EVENT_OBJECTID];
    
    /// TODO may not need update user here
    User * user = [User convertFromRemoteUser:object[PF_EVENT_USER] inManagedObjectContext:context];
    event.user = user;
    
    event.members = object[PF_EVENT_MEMBERS] ;
    event.name = object[PF_EVENT_NAME] ;
    event.createTime = object.createdAt ;
    event.updateTime = object.updatedAt ;
    
}

@end
