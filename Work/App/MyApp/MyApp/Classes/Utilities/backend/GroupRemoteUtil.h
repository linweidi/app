//
//  GroupRemoteUtil.h
//  MyApp
//
//  Created by Linwei Ding on 9/30/15.
//  Copyright (c) 2015 AppsFoundation. All rights reserved.
//
#import "AppHeader.h"
#import <Foundation/Foundation.h>

@interface GroupRemoteUtil : NSObject
+ (GroupRemoteUtil *)sharedUtil;

- (void) loadRemoteGroups:(Group *)latestGroup completionHandler:(REMOTE_ARRAY_BLOCK)block ;
@end
