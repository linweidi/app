//
//  EventCategoryRemoteUtil.m
//  MyApp
//
//  Created by Linwei Ding on 11/14/15.
//  Copyright © 2015 Linweiding. All rights reserved.
//

#import "EventCategoryRemoteUtil.h"

@implementation EventCategoryRemoteUtil

+ (EventCategoryRemoteUtil *)sharedUtil {
    static dispatch_once_t predicate = 0;
    static EventCategoryRemoteUtil *sharedObject;
    
    dispatch_once(&predicate, ^{
        //initializing singleton object
        sharedObject = [[self alloc] init];
        
        sharedObject.className = PF_MESSAGE_CLASS_NAME;
    });
    return sharedObject;
}

@end
