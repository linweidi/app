//
//  FileRemoteUtil.m
//  MyApp
//
//  Created by Linwei Ding on 9/30/15.
//  Copyright (c) 2015 AppsFoundation. All rights reserved.
//

#import "FileRemoteUtil.h"

@implementation FileRemoteUtil
+ (FileRemoteUtil *)sharedUtil {
    static dispatch_once_t predicate = 0;
    static FileRemoteUtil *sharedObject;
    
    dispatch_once(&predicate, ^{
        //initializing singleton object
        sharedObject = [[self alloc] init];
        
    });
    return sharedObject;
}


@end
